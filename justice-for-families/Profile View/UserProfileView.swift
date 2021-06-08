//
//  UserProfileView.swift
//  justice-for-families
//
//  Created by Sydney Chiang on 2/11/21.
//

import Foundation
import SwiftUI
import Combine
import SwiftUIRefresh

struct PostsAndLikedView: View {
    
    var username: String
    @Binding var index: Int
    var body: some View {
        HStack(spacing: 0){
            Spacer()
            Text("Posts")
                .foregroundColor(self.index == 0 ? J4FColors.darkBlue : J4FColors.darkBlue.opacity(0.7))
                .fontWeight(.bold)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .onTapGesture {
                    self.index = 0
                }
            Spacer()
            if UserDefaults.standard.string(forKey: "LoggedInUser")  == username {
                Text("Liked")
                    .foregroundColor(self.index == 1 ? J4FColors.darkBlue : J4FColors.darkBlue.opacity(0.7))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .onTapGesture {
                        self.index = 1
                    }
                Spacer()
            }

        }
        .padding(.horizontal)
        .padding(.top, 25)
    }
}

struct UIUserProfileView : View{

    @State var index = 0
    @StateObject var model: AuthenticationData
    @State private var isShowing = false
    var username: String
    @ObservedObject var networkManager: ProfileNetworkManager
    var isTabView : Bool

    init(model: AuthenticationData, username: String, isTabView: Bool){
        self._model = StateObject(wrappedValue: model)
        self.username = username
        self.networkManager = ProfileNetworkManager(username: username)
        self.isTabView = isTabView
    }

    @ViewBuilder
    var body: some View {
        VStack {
            BioView(model: model, networkManager: networkManager, username: username, isTabView: isTabView)
            PostsAndLikedView(username: username, index: $index)
            TabView(selection: self.$index){
                VStack{
                    if(self.index == 0){
                        List {
                            if UserDefaults.standard.string(forKey: "LoggedInUser")  == username{
                                ForEach(networkManager.posts) { p in
                                    FeedCell(post: p, model: model, isTabView: false)
                                        .listRowBackground(J4FColors.background)
                                }
                            }else{
                                ForEach(networkManager.anonPosts) { p in
                                    FeedCell(post: p, model: model
                                             , isTabView: false)
                                        .listRowBackground(J4FColors.background)
                                }
                            }
                        }
                        .pullToRefresh(isShowing: $isShowing, onRefresh: {
                            networkManager.getPosts()
                            self.isShowing = false
                        })

                    }
                    else{
                        List {
                            ForEach(networkManager.likedPosts) { p in
                                FeedCell(post: p, model: model, isTabView: false)
                            }

                        }
                        .pullToRefresh(isShowing: $isShowing, onRefresh: {
                            networkManager.getLikedPosts()
                            self.isShowing = false
                        })
                    }

                }
                
                .navigationBarItems(trailing:
                        
                    Menu("...") {
                        if UserDefaults.standard.string(forKey: "LoggedInUser")  == username{
                            Link("End User License Agreement", destination: URL(string: "https://docs.google.com/document/d/1yJIP6Q2y6Wnty8I_h_wAdCQY2qQrNEniOiQdXgTBSuw/edit?usp=sharing")!)
                            Button("Logout", action: {model.logout()})

                        } else {
                            Button(action: {
                                print("user blocked")
                            }, label: {
                                Text("Block User")
                                    .foregroundColor(.red)
                            })
                        }
                })
                .navigationBarTitle(Network.getDisplayUsername(fromUsername: username), displayMode: .inline)
            }

            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }


        .padding(.top)
    }

}



struct BioView : View {
    @StateObject var model: AuthenticationData
    @ObservedObject var networkManager: ProfileNetworkManager
    var username: String
    var isTabView : Bool

    var body: some View {
        
        HStack {
            Image(uiImage: (networkManager.profilePicture ?? UIImage(systemName: "person.circle"))!)
                .resizable()
                .frame(width: 90, height: 90, alignment: .leading)
                .cornerRadius(45)
                .aspectRatio(contentMode: .fit)
                .clipped()
            VStack(alignment: .leading) {
                Text(Network.getDisplayUsername(fromUsername: username))
                    .font(.custom("Poppins-Medium", size: 19))
                    .foregroundColor(J4FColors.darkBlue)
                if UserDefaults.standard.string(forKey: "LoggedInUser")  == username && isTabView{
                    NavigationLink(destination: EditProfileView(model: model)) {
                        Text("Edit Profile")
                            .padding()
                            .frame(width:150, height: 24)
                            .background(J4FColors.darkBlue)
                            .foregroundColor(.white)
                            .cornerRadius(100)
                    }
                }
            }
        }
    }
}


class ProfileNetworkManager: ObservableObject {
    var didChange = PassthroughSubject<ProfileNetworkManager, Never>()
    var username: String
    
    @Published var profilePicture = UIImage(systemName: "person.crop.circle") {
        didSet {
            didChange.send(self)
        }
    }
    
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
    
    @Published var anonPosts = [Post]() {
        didSet {
            didChange.send(self)
        }
    }
    
    init(username: String) {
        self.username = username
        getPosts()
        getLikedPosts()
        getAnonPosts()
        getProfilePicture()
    }

    public func getPosts() {
        Network.getPost(fromUsername: username) {
            (posts) in self.posts = posts.reversed()
            self.posts.forEach { p in
                if let image = ImageCacheHelper.imagecache.object(forKey: p.username as NSString) {
                    p.userProfilePicture = image.image
                } else {
                    Network.getProfilePicture(forUserEmail: self.username) { image in
                        p.objectWillChange.send()
                        p.userProfilePicture = image
                        let imageCache = ImageCache()
                        imageCache.image = image
                        ImageCacheHelper.imagecache.setObject(imageCache, forKey: self.username as NSString)
                    }
                }
            }
        }
    }
    
    public func getLikedPosts() {
        Network.getLikedPosts(fromUsername: username) {
            (posts) in self.likedPosts = posts.reversed()
        }
    }
    
    public func getAnonPosts() {
        Network.getAnonPosts(fromUsername: username) {
            (posts) in self.anonPosts = posts.reversed()
        }
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

struct UserProfileView: View {
    @StateObject var model: AuthenticationData
    var username: String
    var isTabView: Bool

    
    init(model: AuthenticationData, username: String, isTabView: Bool){
        self._model = StateObject(wrappedValue: model)
        self.username = username
        self.isTabView = isTabView
        
    }
    
    var body: some View {
        UIUserProfileView(model: model, username: username, isTabView: isTabView)
    }
}


