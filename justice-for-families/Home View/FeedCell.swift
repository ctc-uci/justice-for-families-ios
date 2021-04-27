//
//  FeedCell.swift
//  justice-for-families
//
//  Created by Jules Labador on 3/6/21.
//

import SwiftUI
import Foundation

struct FeedCell: View {
    
    let post: Post
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white)
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 41, height: 41, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("resources")
                            .frame(width: nil, height: 12, alignment: .center)
                            .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 8))
                            .background(Color(.sRGB, red: 196/255.0, green: 215/255.0, blue: 235/255.0, opacity: 0.3))
                            .cornerRadius(40)
                            .foregroundColor(J4FColors.darkBlue)
                            .font(J4FFonts.postText)
                        Text(post.anonymous  == false ? "@\(post.username)" : "anonymous")
                            .font(J4FFonts.username)
                            .foregroundColor(J4FColors.darkBlue)
                    }
                    //change string into date
                    let isoDate = post.datePosted
                    let dateFormatter = ISO8601DateFormatter()
                    if let newDate =
                        dateFormatter.date(from:isoDate) {
                            Text(newDate.timeAgoDisplay())
                        .font(J4FFonts.postText)
                        .foregroundColor(J4FColors.darkBlue)
                    }
                    Spacer()
                }
                
                Spacer(minLength: 16)
                Text(post.title)
                    .font(J4FFonts.headline)
                    .foregroundColor(J4FColors.darkBlue)
                    .multilineTextAlignment(.leading)
                Spacer(minLength: 16)
                FeedCellInteractButtons(post: post)
                    
            }
            .padding(20)
            // Removes arrow indicators on the right side of the cell
            NavigationLink(destination: PostView(post: post)) { EmptyView() }
            .opacity(0.0)
        }
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
                        "postId": post.DecodedPost._id,
                        "_id": post.DecodedPost._id
                    ])
                    post.objectWillChange.send()
                    post.isLiked = false
                    post.numLikes -= 1
                    
                } else {
                    Network.likePost(parameters: [
                        "username": UserDefaults.standard.object(forKey: "LoggedInUser")!,
                        "postId": post.DecodedPost._id,
                        "_id": post.DecodedPost._id
                    ])
                    post.objectWillChange.send()
                    post.isLiked = true
                    post.numLikes += 1
                    
                }
                
                print(post)
                
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
