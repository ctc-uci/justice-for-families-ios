//
//  FeedCell.swift
//  justice-for-families
//
//  Created by Jules Labador on 3/6/21.
//

import Foundation
import SwiftUI

struct FeedCell: View {
    
    @StateObject var post: Post
    @StateObject var model: AuthenticationData
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white)
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    UserProfilePictureImageView(username: post.username, isAnon: post.anonymous)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            TagCell(tag: post.tags[0])
                            
                            // Checks to see if a second tag exists, then displays another TagCell
                            post.tags.indices.contains(1) == true ? TagCell(tag: post.tags[1]) : nil
                        }


                        
                        Text(post.anonymous  == false ? Network.getDisplayUsername(fromUsername: post.username) : "anonymous")
                            .font(J4FFonts.username)
                            .foregroundColor(J4FColors.darkBlue)
                            .lineLimit(1)
                    }
                    Spacer()
                     //change string into date
                     let isoDate = post.datePosted
                     let trimmedIsoString = isoDate.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)

                     let dateFormatter = ISO8601DateFormatter()
                     //Text(isoDate)
                     if let newDate =
                         dateFormatter.date(from:trimmedIsoString) {
                         Text(newDate.timeAgoDisplay())
                             .multilineTextAlignment(.trailing)
                         .font(J4FFonts.postText)
                         .foregroundColor(J4FColors.darkBlue)
                                 
                     }

                }
                
                Spacer(minLength: 16)
                Text(post.title)
                    .font(J4FFonts.headline)
                    .foregroundColor(J4FColors.darkBlue)
                    .multilineTextAlignment(.leading)
                    .lineLimit(4)
                Spacer(minLength: 16)
                Text(post.text)
                    .font(J4FFonts.postText)
                    .multilineTextAlignment(.leading)
                    .lineLimit(4)
                Spacer(minLength: 16)
                FeedCellInteractButtons(post: post)
                    
            }
            .padding(20)
            // Removes arrow indicators on the right side of the cell
            NavigationLink(destination: PostView(post: post, model: model)) { EmptyView() }
            .opacity(0.0)
        }
        .listRowBackground(J4FColors.background)
    }
}

struct FeedCellInteractButtons: View {
    
    @StateObject var post: Post
    
    var body: some View {
        HStack {
            
            Button(action: {
                
                if post.isLiked {
                    Network.unlikePost(parameters: [
                        "username": UserDefaults.standard.object(forKey: "LoggedInUser")!,
                        "postId": post.decodedPost._id,
                        "_id": post.decodedPost._id
                    ])
                    post.objectWillChange.send()
                    post.isLiked = false
                    post.numLikes -= 1
                    
                } else {
                    Network.likePost(parameters: [
                        "username": UserDefaults.standard.object(forKey: "LoggedInUser")!,
                        "postId": post.decodedPost._id,
                        "_id": post.decodedPost._id
                    ])
                    post.objectWillChange.send()
                    post.isLiked = true
                    post.numLikes += 1
                    
                }
                
                
            }) {
                HStack(alignment: .center) {
                    Image(systemName: post.isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .renderingMode(.template)
                        .foregroundColor(J4FColors.orange)
                    Text("\(post.numLikes) likes")
                        .font(J4FFonts.button)
                        .foregroundColor(J4FColors.darkBlue)
                }
                
            }
            // Prevents all three buttons from detecting a tap when the row is tapped on
            .buttonStyle(BorderlessButtonStyle())
            
            Spacer()
            
            Button(action: {
//                print("Tapped on the comment button!")
            }) {
                HStack(alignment: .center) {
                    Image(systemName: "bubble.left")
                        .renderingMode(.template)
                        .foregroundColor(J4FColors.orange)
                    Text("\(post.numComments) comments")
                        .font(J4FFonts.button)
                        .foregroundColor(J4FColors.darkBlue)
                }
                
            }
            // Prevents all three buttons from detecting a tap when the row is tapped on
            .buttonStyle(BorderlessButtonStyle())
            
            Spacer()
            
        }
    }
}
