//
//  EditProfileView.swift
//  justice-for-families
//
//  Created by Sydney Chiang on 2/26/21.
//

import Foundation
import SwiftUI
import Combine
import SwiftUIRefresh

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var model: AuthenticationData
    @ObservedObject var networkManager: EditProfileNetworkManager = EditProfileNetworkManager()
    @State private var showingActionSheet = false

    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var newPassword = ""
    
    @State private var image: Image? = Image(uiImage:
                                                ImageCacheHelper.imagecache.object(forKey: (UserDefaults.standard.string(forKey: "LoggedInUser") ?? "" as String)
                                                as NSString)!.image)
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var selectedImageType: String = "image/jpeg"
    
    @State private var didSaveChanges = true

    
    var body: some View{
        NavigationView {
            VStack{
                Button(action: {
                    self.showingImagePicker = true
                }) {
                    VStack {
                        if image != nil  {
                            image?
                                .resizable()
                                .frame(width: 120, height: 120)
                                .scaledToFit()
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle")
                                .font(.system(size: 110, weight: .regular))
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                        }
                        Text("Change Profile Photo")
                            .foregroundColor(J4FColors.lightBlue)
                            .font(Font.custom("Poppins-Medium", size: 14.0))
                    }
                }.buttonStyle(PlainButtonStyle())
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$selectedImage)
                    
                }
                Spacer()
                
            }
        }
        .navigationBarTitle("Edit Profile", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
                                    if !didSaveChanges {
                                        self.showingActionSheet = true
                                    } else {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                    
                                }){
                                    Image(systemName: "xmark").font(.system(size: 16, weight: .regular))
                                },
                            trailing:
                                Button(action: {
                                    didSaveChanges = true
                                    didTapSave()
                                }){
                                    Text("Save")
                                }
                            
        )
        .actionSheet(isPresented: $showingActionSheet ){
            ActionSheet(title: Text("There are unsaved changes."),
                        message: Text("Do you want to continue?"),
                        buttons: [
                            .default(Text("Continue")) {self.presentationMode.wrappedValue.dismiss()},
                            .cancel()
                        ])
        }
    }
    
    func loadImage() {
        guard let inputImage = selectedImage else { return }
        image = Image(uiImage: inputImage)
        didSaveChanges = false
    }
    
    private func didTapSave() {
        
//                    UNCOMMENT THIS IF YOU WANT TO CHANGE PASSWORD
//                    if newPassword.count > 0 { //check if valid? add error messages?
//                        networkManager.changePassword(oldPassword: password, newPassword: newPassword)
//                    }
//                    else{
//                        print("new password invalid")
//                    }
        if let image = self.selectedImage {
            upload(image)
        }
    }
    
    private func upload(_ image: UIImage) {
        getS3SignedURL(forImage: image,
                       withContentType: selectedImageType)
    }
    
    private func getS3SignedURL(forImage image: UIImage,
                                withContentType contentType: String) {
        Network.getS3SignedURL(
            forContentType: contentType) { (result) in
            switch result {
                case .success(let urls):
                    print("🟡 Received S3 URLs for \(contentType) content type -- \n\tUpload URL: \(urls.uploadURL)\n\tPath: \(urls.path)")
                    put(image: image, toUploadURL: urls.uploadURL, withPath: urls.path)
                    
                case .failure(let error):
                    print("🔥 \(error)")
            }
        }
    }
    
    private func put(image: UIImage, toUploadURL url: String, withPath path: String) {
        guard let jpegImage = image.jpegData(compressionQuality: 0.01) else {
            print("🔴 Error trying to convert image to jpeg")
            return
        }
        
        Network.upload(imageData: jpegImage, toURL: url) { (result) in
            switch result {
                case .success(_):
                    print("🟡 Stored image data to S3 at path: \(path)")
                    updateProfile(withURL: path)
                case .failure(let error):
                    print("🔥 \(error)")
            }
        }
    }
    
    private func updateProfile(withURL url: String) {
        let user = UserDefaults.standard.string(forKey: "LoggedInUser")!
        Network.updateProfilePicture(
            forUser: user,
            withImageURL: url
        ) { (result) in
            switch result {
                case .success(let statusCode):
                    switch statusCode {
                        case 200:
                            print("🟢 Successfully uploaded and updated profile picture")
                            guard let imageURL = URL(string: url) else { return }
                            Network.download(imageFromUrl: imageURL) { image in
                                let imageCache = ImageCache()
                                imageCache.image = image
                                ImageCacheHelper.imagecache.setObject(imageCache, forKey: user as NSString)
                            }
                            self.presentationMode.wrappedValue.dismiss()
                        default:
                            print("🔥 Error saving profile picture")
                    }
                    
                case .failure(let error):
                    print("🔥 \(error)")
            }
        }
    }
    
}

class EditProfileNetworkManager: ObservableObject {
    var didChange = PassthroughSubject<EditProfileNetworkManager, Never>()

    @Published var posts = [Post]() {
        didSet {
            didChange.send(self)
        }
    }

    @Published var likedPosts = [Post]() {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        
    }

    public func changePassword(oldPassword: String, newPassword: String) {
//        Network.changePassword(fromUsername: UserDefaults.standard.string(forKey: "LoggedInUser") ?? "", fromPassword: oldPassword, fromNewPassword: newPassword)
    }
    
    public func getLikedPosts() {
        Network.getLikedPosts(fromUsername: UserDefaults.standard.string(forKey: "LoggedInUser") ?? "") {
            (posts) in self.likedPosts = posts.reversed()
        }
    }
}
