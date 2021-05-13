//
//  Home Feed.swift
//  justice-for-families
//
//  Created by Jules Labador on 1/11/21.
//


import SwiftUI
import Combine
import SwiftUIRefresh

struct Update: Identifiable {
    var id: UUID = UUID()
    var numberOfLikes: Int
    var numberOfComments: Int
}

class NetworkManager: ObservableObject {
    
    var didChange = PassthroughSubject<NetworkManager, Never>()
    var username = UserDefaults.standard.string(forKey: "LoggedInUser") ?? ""
    
    @Published var posts = [Post]() {
        didSet {
            didChange.send(self)
        }
    }
    @Published var whatYouMissedPosts = [ActivityComment]() {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        fetchPosts()
        fetchWhatYouMissed()
    }
    
    public func fetchPosts() {
        Network.fetchAllPosts { (posts) in
            self.posts = posts.reversed()
            posts.forEach { (p) in
                Network.hasLiked(forPostID: p.decodedPost._id, username: self.username) { (result) in
                    switch result {
                    case .success(let isLiked):
//                        print("🟡 (\(p.DecodedPost._id)) -- Has liked \(p.title)? - \(isLiked)")
                        p.isLiked = isLiked
                    case .failure(_):
                        print("🔴 Error trying to check if logged in user has liked post: \(p.decodedPost._id)")
                    }
                }
            }
        }
        
    }
    
    public func fetchWhatYouMissed() {
        Network.getWhatYouMissed { (posts) in
            self.whatYouMissedPosts = posts.comments
        }
        
    }
    
    
    
}

struct HomeFeed: View {
    
    @State private var isShowing = false
    @ObservedObject var networkManager = NetworkManager()
    @StateObject var model: AuthenticationData
    
    var body: some View {

        NavigationView {
            VStack(alignment: .leading){
                
                Text("What you missed...")
                    .font(J4FFonts.postTitle)
                    .padding(.leading, 15)
                ScrollView(.horizontal, showsIndicators: false, content: {
                    
                    HStack{
                        Spacer(minLength: 15)
                        ForEach(networkManager.whatYouMissedPosts, id: \.self){ activityComment in
                            NavigationLink(destination: PostView(postID: activityComment.postID, model: model)) {
                                WhatYouMissedCell(post: activityComment)
                            }
                        }
                        Spacer(minLength: 15)
                    }

            
                })
                .listRowInsets(EdgeInsets())
                
                

                List(networkManager.posts) { p in
                    NavigationLink(destination: PostView(post: p, model: model)) {
                        FeedCell(post: p, model: model)
                            .listStyle(PlainListStyle())
                            
                    }
                    .listStyle(PlainListStyle())
                }
                
                
            }.pullToRefresh(isShowing: $isShowing) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                   networkManager.fetchPosts()
                    networkManager.fetchWhatYouMissed()
                   self.isShowing = false
                }


            }
//            .navigationBarHidden(true)
            .navigationBarTitle("J4F")
        }

        // Goodbye 5head :)
        .navigationBarBackButtonHidden(true)

    }
}
    

struct SectionHeader: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 0))
            .textCase(.none)
            .font(J4FFonts.sectionTitle)
            .frame(width: UIScreen.main.bounds.width, height: 60, alignment: .leading)
            .background(J4FColors.background)
            .foregroundColor(J4FColors.darkBlue)
    }
}
