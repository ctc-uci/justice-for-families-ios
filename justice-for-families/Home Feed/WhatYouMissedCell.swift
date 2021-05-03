//
//  WhatYouMissedCell.swift
//  justice-for-families
//
//  Created by Joshua Chan on 4/28/21.
//

import Foundation
import Combine
import SwiftUI

class WYMNetworkManager: ObservableObject {
    var didChange = PassthroughSubject<WYMNetworkManager, Never>()
    var username = UserDefaults.standard.string(forKey: "LoggedInUser") ?? ""
    var activityComment: ActivityComment
    @Published var post : Post{
        didSet {
            didChange.send(self)
        }
    }
    
    init(fromActivityComment activityComment: ActivityComment) {
//        print(activityComment)
        self.activityComment = activityComment
        self.post = Post(anonymous: true, datePosted: "", createdAt: "", updatedAt: "", numComments: 0, numLikes: 0, tags: [], title: "", text: "", username: "", DecodedPost: DecodedPost(__v: 0, _id: "", anonymous: true, datePosted: "", createdAt: "", updatedAt: "", numComments: 0, numLikes: 0, tags: [], title: "", text: "", username: ""))
        
        
        Network.getPost(fromPostID: activityComment.postID){ (post) in
            self.post = post
//            print(post)
            /*
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
            }*/
        }
            
    }
    

        
        
    
    
    
}
struct WhatYouMissedCell: View {
    let post: ActivityComment

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(Color(.sRGB, red: 196/255.0, green: 215/255.0, blue: 235/255.0, opacity: 0.3))
            VStack(alignment: .center){
                Text("@\(post.commentUsername) commented on your post!").fixedSize(horizontal: false, vertical: true).font(.system(size: 12))
                Spacer()
                
                //copied from FeedCell time
                let isoDate = post.commentDatePosted
                let trimmedIsoString = isoDate.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)

                let dateFormatter = ISO8601DateFormatter()
                if let newDate =
                    dateFormatter.date(from:trimmedIsoString) {
                    Text(newDate.timeAgoDisplay())
                        .multilineTextAlignment(.trailing)
                    .font(J4FFonts.postText)
                    .foregroundColor(J4FColors.darkBlue)
                            
                }
            }
            .padding(20)
            let networkManager = WYMNetworkManager(fromActivityComment: post)
            NavigationLink(destination: PostView(post: networkManager.post)) { EmptyView() }
            .opacity(0.0)
        }
        .frame(width: 140, height: 80)
    }
}
