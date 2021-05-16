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

struct UserLikedPostsView: View {
    
    @Binding var isShowing: Bool
    @ObservedObject var networkManager: ProfileNetworkManager
    var username: String
    @StateObject var model: AuthenticationData
    
    var body: some View {
        List {
            Section() {
                ForEach(networkManager.likedPosts) { p in
                    FeedCell(post: p, model: model)
                        .listRowBackground(J4FColors.background)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .pullToRefresh(isShowing: $isShowing, onRefresh: {
            networkManager.getLikedPosts()
            self.isShowing = false
        })
    }
}

struct UserPostsView: View {
    
    @Binding var isShowing: Bool
    @ObservedObject var networkManager: ProfileNetworkManager
    var username: String
    @StateObject var model: AuthenticationData
    
    var body: some View {
        List {
            Section() {
                if UserDefaults.standard.string(forKey: "LoggedInUser")  == username {
                    ForEach(networkManager.posts) { p in
                        FeedCell(post: p, model: model)
                            .listRowBackground(J4FColors.background)
                    }
                }else{
                    ForEach(networkManager.anonPosts) { p in
                        FeedCell(post: p, model: model)
                            .listRowBackground(J4FColors.background)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .pullToRefresh(isShowing: $isShowing, onRefresh: {
            networkManager.getPosts()
            self.isShowing = false
        })
    }
}

struct UIUserProfileView : View{
    
    @State var index = 0
    @StateObject var model: AuthenticationData
    @State private var isShowing = false
    var username: String
    @ObservedObject var networkManager: ProfileNetworkManager
    
    init(model: AuthenticationData, username: String){
        self._model = StateObject(wrappedValue: model)
        self.username = username
        self.networkManager = ProfileNetworkManager(username: username)
    }
    
    @ViewBuilder
    var body: some View {
        
        VStack {
            BioView(model: model, networkManager: networkManager, username: username)
            PostsAndLikedView(username: username, index: $index)
            TabView(selection: self.$index){
                VStack{
                    if(self.index == 0){
                        List {
                            if UserDefaults.standard.string(forKey: "LoggedInUser")  == username{
                                ForEach(networkManager.posts) { p in
                                    FeedCell(post: p, model: model)
                                        .listRowBackground(J4FColors.background)
                                }
                            }else{
                                ForEach(networkManager.anonPosts) { p in
                                    FeedCell(post: p, model: model)
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
                                FeedCell(post: p, model: model)
                            }
                            
                        }
                        .pullToRefresh(isShowing: $isShowing, onRefresh: {
                            networkManager.getLikedPosts()
                            self.isShowing = false
                        })
                    }

                }
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

    var body: some View {
        
        HStack {
            Image(systemName: "person.circle").font(.system(size: 90, weight: .regular))
            VStack(alignment: .leading) {
                Text(Network.getDisplayUsername(fromUsername: username))
                    .font(.custom("Poppins-Medium", size: 19))
                    .foregroundColor(J4FColors.darkBlue)
                if UserDefaults.standard.string(forKey: "LoggedInUser")  == username{
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
        
    }

    public func getPosts() {
        Network.getPost(fromUsername: username) {
            (posts) in self.posts = posts.reversed()
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
    

}

struct UserProfileView: View {
    @StateObject var model: AuthenticationData
    var username: String
    var body: some View {
        UIUserProfileView(model: model, username: username)
            .navigationBarTitle(username, displayMode: .inline)
            .navigationBarItems(trailing:
                Menu("...") {
                    Button("Logout", action: {model.logout()
                })
            })
    }
}

