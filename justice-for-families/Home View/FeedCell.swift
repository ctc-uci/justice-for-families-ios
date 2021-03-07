//
//  FeedCell.swift
//  justice-for-families
//
//  Created by Jules Labador on 3/6/21.
//

import SwiftUI

struct FeedCell: View {
    
    let post: Post
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white)
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 41, height: 41, alignment: .leading)
                    
                    Text("@\(post.username)")
                        .font(J4FFonts.username)
                        .foregroundColor(J4FColors.primaryText)
                    Text("3h")
                        .font(J4FFonts.postText)
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
            // Removes arrow indicators on the right side of the cell
            NavigationLink(destination: PostView()) {
                EmptyView()
            }
            .opacity(0.0)
        }
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
                        .renderingMode(.template)
                        .foregroundColor(J4FColors.orange)
                    Text("\(self.numLikes) likes")
                        .font(J4FFonts.button)
                        .foregroundColor(J4FColors.primaryText)
                }
                
            }
            // Prevents all three buttons from detecting a tap when the row is tapped on
            .buttonStyle(BorderlessButtonStyle())
            
            Spacer()
            
            Button(action: {
                print("Tapped on the comment button!")
            }) {
                HStack(alignment: .center) {
                    Image(systemName: "bubble.left")
                        .renderingMode(.template)
                        .foregroundColor(J4FColors.orange)
                    Text("\(self.numComments) comments")
                        .font(J4FFonts.button)
                        .foregroundColor(J4FColors.primaryText)
                }
                
            }
            // Prevents all three buttons from detecting a tap when the row is tapped on
            .buttonStyle(BorderlessButtonStyle())
            
            Spacer()
            
            Button(action: {
                print("Tapped on the like button!")
            }) {
                HStack(alignment: .center) {
                    Image(systemName: "square.and.arrow.up")
                        .renderingMode(.template)
                        .foregroundColor(J4FColors.orange)
                    Text("10 shares")
                        .font(J4FFonts.button)
                        .foregroundColor(J4FColors.primaryText)
                }
                
            }
            // Prevents all three buttons from detecting a tap when the row is tapped on
            .buttonStyle(BorderlessButtonStyle())
            
        }
    }
}
