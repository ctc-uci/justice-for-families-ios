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

struct UIUserProfileView : View{
    @State var index = 0
    @StateObject var model: AuthenticationData
    @ObservedObject var networkManager: ProfileNetworkManager = ProfileNetworkManager()
    @State private var isShowing = false
    
    @ViewBuilder
    var body: some View{
        VStack{
            BioView()
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
            .padding(.horizontal)
            .padding(.top, 25)

            TabView(selection: self.$index){
                VStack{
                    if(self.index == 0){
                        List {
                            
                            Section() {
                                ForEach(networkManager.posts) { p in
                                    FeedCell(post: p)
                                        .listRowBackground(J4FColors.background)
                                }
                            }
                        }
                        .listStyle(GroupedListStyle())
                        .pullToRefresh(isShowing: $isShowing, onRefresh: {
                            networkManager.getPosts()
                            self.isShowing = false
                        })

                    }
                    else{
                        List {
                            
                            Section() {
                                ForEach(networkManager.likedPosts) { p in
                                    FeedCell(post: p)
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
                .navigationBarTitle(UserDefaults.standard.string(forKey: "LoggedInUser") ?? "", displayMode: .inline)
                .navigationBarItems(trailing:

                    Menu("...") {
                        Button("Logout", action: {model.logout()
                    })
                })

            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

        }
        .padding(.top)
    }

}






struct BioView : View {

    var body: some View {
        
        HStack {
            Image(systemName: "person.circle").font(.system(size: 90, weight: .regular))
            VStack(alignment: .leading) {
                Text(UserDefaults.standard.string(forKey: "LoggedInUser") ?? "")
                    .font(.custom("Poppins-Medium", size: 19))
                    .foregroundColor(J4FColors.darkBlue)
                
//                NavigationLink(destination: EditProfileView()) {
//                    Text("Edit Profile")
//                        .padding()
//                        .frame(width:150, height: 24)
//                        .background(profileColors.primaryColor2)
//                        .foregroundColor(.white)
//                        .cornerRadius(100)
//
//                }
            }
        }


    }

}


class ProfileNetworkManager: ObservableObject {
    var didChange = PassthroughSubject<ProfileNetworkManager, Never>()

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
        getPosts()
        getLikedPosts()
    }

    public func getPosts() {
        Network.getPost(fromUsername: UserDefaults.standard.string(forKey: "LoggedInUser") ?? "") {
            (posts) in self.posts = posts.reversed()
        }
    }
    
    public func getLikedPosts() {
        Network.getLikedPosts(fromUsername: UserDefaults.standard.string(forKey: "LoggedInUser") ?? "") {
            (posts) in self.likedPosts = posts.reversed()
        }
    }
    
    
    

}




struct UserProfileView: View {
    @StateObject var model: AuthenticationData
    var body: some View {
        NavigationView {
            UIUserProfileView(model: model)
        }
    }
}

