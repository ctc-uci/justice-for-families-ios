//
//  Post.swift
//  justice-for-families
//
//  Created by Sydney Chiang on 12/8/20.
//
import Foundation
import SwiftUI
import Combine
import Alamofire

struct SheetPresenter<Main>: View where Main: View {
    @Binding var isPresentingSheet: Bool
    var content: Main
    var body: some View {
        Text("")
            .sheet(isPresented: self.$isPresentingSheet, content: { self.content })
            .onAppear {
                print("🔴", isPresentingSheet)
                DispatchQueue.main.async { self.isPresentingSheet = true }
            }
            .onDisappear {
                print("🔴", isPresentingSheet)
            }
    }
}

struct AddPostView: View {
    @State private var showingTags = false
    
    @State var title: String = ""
    @State var postBody: String = "What's on your mind?"
    @State var isAnon: Bool = false
    @State var tags: Array<String> = []
    @ObservedObject var networkManager: AddPostNetworkManager = AddPostNetworkManager(username: UserDefaults.standard.string(forKey: "LoggedInUser") ?? "")

    @Environment(\.presentationMode) private var presentationMode
    
    let postURL = URL(string: "https://j4f-backend.herokuapp.com/posts/create")
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Image(uiImage: (networkManager.profilePicture ?? UIImage(systemName: "person.circle"))!)
                        .resizable()
                        .frame(width: 47, height: 47)
                        .background(Color.gray)
                        .cornerRadius(30)
                        .padding(EdgeInsets(top: 16, leading: 24, bottom: 0, trailing: 0))
                        
                    if tags.isEmpty {
                        Button(action: {
                            showingTags.toggle()
                        }, label: {
                            Text("Add tags")
                                .frame(minWidth: 130, minHeight: 21.0, alignment: .leading)
                                .foregroundColor(Constants.primaryFontColor)
                                .padding(EdgeInsets(top: 16, leading: 7, bottom: 0, trailing: 24))
                        }).sheet(isPresented: $showingTags) {
                            AddTagsView(tags: $tags)
                        }
                    } else {
                        HStack(spacing: 5) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack (spacing: 4) {
                                    ForEach(tags, id: \.self) { tag in
                                        Text(tag.description)
                                            .font(.custom("Poppins-Regular", size:11))
                                            .frame(alignment: .center)
                                            .padding(EdgeInsets(top: 4, leading: 9, bottom: 4, trailing: 9))
                                            .foregroundColor(.white)
                                            .background(RoundedRectangle(cornerRadius: 40.0)
                                                            .fill(Constants.secondaryFontColor))
                                            .overlay(RoundedRectangle(cornerRadius: 40.0)
                                                        .stroke(Constants.secondaryFontColor, lineWidth: 0.5))
                                    }
                                }.padding(.top, 10)
                            }.frame(minWidth: 100, maxWidth: 110, alignment: .leading)
                            Button(action: {
                                showingTags.toggle()
                            }, label: {
                                Image(systemName: "plus.circle")
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Constants.primaryFontColor)
                            }).sheet(isPresented: $showingTags) {
                                AddTagsView(tags: $tags)
                            }.padding(.top, 10)
                        }
                    }

                    VStack(alignment: .trailing, spacing: 5) {
                        Toggle("Anonymous posting", isOn: $isAnon)
                            .labelsHidden()
                            .frame(alignment: .leading)
                            .toggleStyle(SwitchToggleStyle(tint: Constants.primaryFontColor))
                            .padding(EdgeInsets(top: 22, leading: 0, bottom: 0, trailing: 16))
                        Text("Anonymous posting")
                            .foregroundColor(Constants.subtitleFontColor)
                            .font(.custom("Poppins-Regular", size: 7.5))
                            .padding(.leading, 15)
                    }
                }
                Divider().padding([.leading, .trailing], 24)
                TextField("Add Title (required)", text: $title)
                    .font(.custom("Poppins-Regular", size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Constants.primaryFontColor)
                    .padding(EdgeInsets(top: 12, leading: 36, bottom: 12, trailing: 24))
                Divider().padding([.leading, .trailing], 24)
                TextEditor(text: $postBody)
                    .font(.custom("Poppins-Regular", size: 12))
                    .foregroundColor(Constants.subtitleFontColor)
                    .onAppear {
                        // remove the placeholder text when keyboard appears
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                            withAnimation {
                                if postBody == "What's on your mind?" {
                                    postBody = ""
                                }
                            }
                        }
                        
                        // put back the placeholder text if the user dismisses the keyboard without adding any text
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                            withAnimation {
                                if postBody == "" {
                                    postBody = "What's on your mind?"
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 4, leading: 32, bottom: 0, trailing: 24))
                
                Spacer()
            }
            .navigationBarTitle("Text Post")
            .navigationBarTitleDisplayMode(.inline)
            .font(.custom("Poppins-Regular", size: 16))
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark").font(.system(size: 16, weight: .regular))
            }, trailing:
                Button(action: {
                    //username is your email
                    let parameters = ["text" : postBody,
                                      "username" : UserDefaults.standard.object(forKey: "LoggedInUser")!,
                                      "tags" : tags,
                                      "numComments" : 0,
                                      "title" : title,
                                      "anonymous" : isAnon,
                                      "numLikes" : 0] as [String : Any]
                    if (title.count > 0) {
                        Network.createNewPost(parameters: parameters)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    Text("POST")
                })
            )
        }
    }
}


class AddPostNetworkManager: ObservableObject {
    var didChange = PassthroughSubject<AddPostNetworkManager, Never>()
    var username: String
    
    @Published var profilePicture = UIImage(systemName: "person.crop.circle")

    
    init(username: String) {
        self.username = username
        getProfilePicture()
    }
    
    public func getProfilePicture() {
        if let image = ImageCacheHelper.imagecache.object(forKey: username as NSString) {
            self.profilePicture = image.image
        } else {
            Network.getProfilePicture(forUserEmail: username) { image in
                self.profilePicture = image
                let imageCache = ImageCache()
                imageCache.image = image
                ImageCacheHelper.imagecache.setObject(imageCache, forKey: self.username as NSString)
            }
        }
        
    }
    


}
