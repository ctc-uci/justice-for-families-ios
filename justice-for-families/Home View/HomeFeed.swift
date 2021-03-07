//
//  Home Feed.swift
//  justice-for-families
//
//  Created by Jules Labador on 1/11/21.
//

import SwiftUI
import Combine

struct Update: Identifiable {
    var id: UUID = UUID()
    var numberOfLikes: Int
    var numberOfComments: Int
}

class NetworkManager: ObservableObject {
    var didChange = PassthroughSubject<NetworkManager, Never>()
    
    @Published var posts = [Post]() {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        fetchPosts()
    }
    
    public func fetchPosts() {
        Network.fetchAllPosts { (posts) in
            self.posts = posts
            posts.forEach({
                print($0)
            })
        }
    }
    
    
    
}

struct HomeFeed: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    private let posts: [Post] = [
//        Post(id: UUID(), text: "Test 1"),
//        Post(id: UUID(), text: "Test 2"),
//        Post(id: UUID(), text: "Test 3")
    ]
        
    private let updates: [Update] = [
        .init(numberOfLikes: 1, numberOfComments: 1),
        .init(numberOfLikes: 10, numberOfComments: 10),
        .init(numberOfLikes: 100, numberOfComments: 100),
        .init(numberOfLikes: 1000, numberOfComments: 1000),
        .init(numberOfLikes: 1, numberOfComments: 1),
        .init(numberOfLikes: 10, numberOfComments: 10),
        .init(numberOfLikes: 100, numberOfComments: 100),
        .init(numberOfLikes: 1000, numberOfComments: 1000),
        .init(numberOfLikes: 1, numberOfComments: 1),
        .init(numberOfLikes: 10, numberOfComments: 10),
        .init(numberOfLikes: 100, numberOfComments: 100),
        .init(numberOfLikes: 1000, numberOfComments: 1000),
        .init(numberOfLikes: 1, numberOfComments: 1),
        .init(numberOfLikes: 10, numberOfComments: 10),
        .init(numberOfLikes: 100, numberOfComments: 100),
        .init(numberOfLikes: 1000, numberOfComments: 1000),
        .init(numberOfLikes: 1, numberOfComments: 1),
        .init(numberOfLikes: 10, numberOfComments: 10),
        .init(numberOfLikes: 100, numberOfComments: 100),
        .init(numberOfLikes: 1000, numberOfComments: 1000),
        .init(numberOfLikes: 1, numberOfComments: 1),
        .init(numberOfLikes: 10, numberOfComments: 10),
        .init(numberOfLikes: 100, numberOfComments: 100),
        .init(numberOfLikes: 1000, numberOfComments: 1000)
    ]

    init() {
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: SectionHeader(title: "Tags you follow")){
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack {
                            ForEach(1..<100) { i in
                                WhatYouMissedCell()
                            }
                        }
                    })
                    .listRowInsets(EdgeInsets())
                    .background(J4FColors.background)
                }.textCase(.none)
                
                Section(header: SectionHeader(title: "What you missed...")){
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack {
                            ForEach(1..<100) { i in
                                WhatYouMissedCell()
                            }
                        }
                    })
                    .listRowInsets(EdgeInsets())
                    .background(J4FColors.background)
                }.textCase(.none)
                
                Section(header: SectionHeader(title: "Feed")) {
                    ForEach(networkManager.posts) { p in
                        FeedCell(post: p)
                            .listRowBackground(J4FColors.background)
                    }
                }.textCase(.none)
                .listStyle(SidebarListStyle())
            }
            .navigationTitle("J4F")
        }
    }
}

struct SectionHeader: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .padding()
            .textCase(.none)
            .font(J4FFonts.sectionTitle)
            .frame(width: UIScreen.main.bounds.width, height: 28, alignment: .leading)
            .background(J4FColors.background)
            .foregroundColor(J4FColors.primaryText)
    }
}


struct HomeFeed_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeFeed()
        }
    }
}
