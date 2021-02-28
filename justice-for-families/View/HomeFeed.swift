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
        }
    }
    
    
    
}

struct J4FColors {
    
    //static let primaryText = Color("primaryText")
    static let primaryText = Color(.black)
}

struct J4FFonts {
    static let sectionTitle = Font.custom("AvenirNext-Medium", size: 15)
    static let headline = Font.custom("AvenirNext-Medium", size: 15)
    static let button = Font.custom("AvenirNext-Regular", size: 10)
    static let username = Font.custom("AvenirNext-Medium", size: 13)
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
    
    var body: some View {
        NavigationView {
            List {
                Section(header: WhatYouMissedSectionHeader()) {
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack {
                            ForEach(1..<100) { i in
                                WhatYouMissedCell()
                            }
                        }
                    })
                }.textCase(.none)
                
                Section(header: FeedSectionHeader()) {
                    ForEach(networkManager.posts) { p in
                        FeedCell(post: p)
                    }
                }.textCase(.none)
            }
            .navigationTitle("J4F")
            
        }
    }
}

struct WhatYouMissedSectionHeader: View {
    var body: some View {
        Text("What you missed...")
            .textCase(.none)
            .font(J4FFonts.sectionTitle)
            .foregroundColor(J4FColors.primaryText)
    }
}

struct WhatYouMissedCell: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(Color(.sRGB, red: 103/255.0, green: 154/255.0, blue: 151/255.0, opacity: 0.20))
            VStack {
                Text("Update")
            }
            .padding(20)
        }
        .frame(width: 140, height: 80)
    }
    
}

struct FeedSectionHeader: View {
    var body: some View {
        Text("Feed")
            .textCase(.none)
            .font(J4FFonts.sectionTitle)
            .foregroundColor(J4FColors.primaryText)
    }
}

struct FeedCellInteractButtons: View {
    
    let numLikes: Int
    let numComments: Int
    
    var body: some View {
        HStack {
            
            Button(action: {
                print("Tapped on the like button!")
            }) {
                HStack(alignment: .center) {
                    Image(systemName: "hand.thumbsup")
                    Text("\(self.numLikes)")
                        .font(J4FFonts.button)
                        .foregroundColor(J4FColors.primaryText)
                }
                
            }
            Spacer()
            Button(action: {
                print("Tapped on the comment button!")
            }) {
                HStack(alignment: .center) {
                    Image(systemName: "bubble.left")
                    Text("\(self.numComments)")
                        .font(J4FFonts.button)
                        .foregroundColor(J4FColors.primaryText)
                }
                
            }
            Spacer()
            Button(action: {
                print("Tapped on the like button!")
            }) {
                HStack(alignment: .center) {
                    Image(systemName: "square.and.arrow.up")
                    Text("10 shares")
                        .font(J4FFonts.button)
                        .foregroundColor(J4FColors.primaryText)
                }
                
            }
            
        }
    }
}

struct FeedCell: View {
    
    let post: Post
    
    var body: some View {
        NavigationLink(destination: PostView()) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.white)
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 41, height: 41, alignment: .leading)
                        
                        Text(post.username)
                            .font(J4FFonts.username)
                            .foregroundColor(J4FColors.primaryText)
                        Spacer()
                    }
                    
                    Spacer(minLength: 16)
                    Text(post.title)
                        .font(J4FFonts.headline)
                        .foregroundColor(J4FColors.primaryText)
                        .multilineTextAlignment(.leading)
                    Spacer(minLength: 16)
                    FeedCellInteractButtons(numLikes: 5, numComments: post.numComments)
                    
                }
                .padding(20)
            }
        }
    }
}


struct HomeFeed_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeFeed()
//            WhatYouMissedSection()
        }
    }
}
