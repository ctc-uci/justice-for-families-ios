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

struct EditProfileView: View{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var model: AuthenticationData
    @ObservedObject var networkManager: EditProfileNetworkManager = EditProfileNetworkManager()
    @State private var showingActionSheet = false

    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var newPassword = ""

    
    var body: some View{
        NavigationView {
            VStack{
                ProfileImgView()
//                TextFieldView()
            
                HStack{
             
                    Text("Username")
                        .font(J4FFonts.headline)
                        .foregroundColor(J4FColors.darkBlue)
                        .opacity(0.6)
                    TextField("@johnnyapples", text: $username)
           
                        
                }.padding()
//                    HStack{
//                        Text("Email")
//                        TextField("johnnyapple123@gmail.com", text: $email)
//                    }
//                    HStack{
//                        Text("Old Password")
//                        TextField("Old Password", text: $password)
//                    }
//                    HStack{
//                        Text("New Password")
//                        TextField("New Password", text: $newPassword)
//                    }
                    //Spacer()
                
                Spacer()
                    .frame(minHeight:400)
            }
        }
        .navigationBarColor(J4FColors.paleBlue)
        .navigationBarTitle("Edit Profile", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                if username.count != 0 || email.count != 0 || password.count != 0 || newPassword.count != 0{
                    self.showingActionSheet = true
                }
                else{
                    self.presentationMode.wrappedValue.dismiss()
                }

            }){
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(J4FColors.darkBlue)
            },
            trailing:
                Button(action: {
                    print("username: \(username)")
                    print("email: \(email)")
                    print("password: \(password)")
                    print("new password: \(newPassword)")
                    
                    
//                    UNCOMMENT THIS IF YOU WANT TO CHANGE PASSWORD
//                    if newPassword.count > 0 { //check if valid? add error messages?
//                        networkManager.changePassword(oldPassword: password, newPassword: newPassword)
//                    }
//                    else{
//                        print("new password invalid")
//                    }

                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("Save")
                        .foregroundColor(J4FColors.lightBlue)
                }
            
        )
        .actionSheet(isPresented: $showingActionSheet ){
            ActionSheet(title: Text("There are unsaved changes."), message: Text("Do you want to continue?"), buttons: [
                    .default(Text("Continue")) {self.presentationMode.wrappedValue.dismiss()},
                    .cancel()
            ])
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

struct ProfileImgView: View{
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View{
        VStack{
            ZStack{
                if image != nil{
                    image?
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 200, height: 200)
                } else {
                    Image(systemName: "person.circle").font(.system(size: 130, weight: .regular))
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
            }
            Button(action: {
                self.showingImagePicker = true
            }) {
                Text("Change Profile Photo")
                    .foregroundColor(J4FColors.lightBlue)
                    .font(J4FFonts.headline)
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)

            }
        }


    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct NavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor?
    init(backgroundColor: Color) {
        self.backgroundColor = UIColor(backgroundColor)
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white

    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
 
    func navigationBarColor(_ backgroundColor: Color) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }

}


