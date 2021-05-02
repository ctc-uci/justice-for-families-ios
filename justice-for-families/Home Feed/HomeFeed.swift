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
                Network.hasLiked(forPostID: p.DecodedPost._id, username: self.username) { (result) in
                    switch result {
                    case .success(let isLiked):
//                        print("🟡 (\(p.DecodedPost._id)) -- Has liked \(p.title)? - \(isLiked)")
                        p.isLiked = isLiked
                    case .failure(_):
                        print("🔴 Error trying to check if logged in user has liked post: \(p.DecodedPost._id)")
                    }
                }
            }
        }
        
    }
    
    public func fetchWhatYouMissed() {
        Network.getWhatYouMissed { (posts) in
            //print("🟡 \(posts)")
            self.whatYouMissedPosts = posts.comments
        }
        
    }
    
    
    
}

struct HomeFeed: View {
    
    @State private var isShowing = false
    @ObservedObject var networkManager = NetworkManager()
    var body: some View {

        NavigationView {
            VStack{
                ScrollView(.horizontal, showsIndicators: false, content: {
                    
                    HStack{
                        ForEach(networkManager.whatYouMissedPosts, id: \.self){ p in
                            WhatYouMissedCell(post: p)
                        }
                    }
                    //WhatYouMissedCell(post: networkManager.whatYouMissedPosts[0])
                })
                .listRowInsets(EdgeInsets())
                .background(J4FColors.background)


                List(networkManager.posts) { p in
                    FeedCell(post: p)
                }
            }.pullToRefresh(isShowing: $isShowing) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                   networkManager.fetchPosts()
                    networkManager.fetchWhatYouMissed()
                   self.isShowing = false
                }
           
            
            }
            
        }
        // Goodbye 5head :)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("J4F")
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
