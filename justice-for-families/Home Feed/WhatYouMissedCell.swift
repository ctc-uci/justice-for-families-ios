//
//  WhatYouMissedCell.swift
//  justice-for-families
//
//  Created by Joshua Chan on 4/28/21.
//

import Foundation

import SwiftUI

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
            
            //NavigationLink(destination: PostView(post: post)) { EmptyView() }
            //.opacity(0.0)
        }
        .frame(width: 140, height: 80)
    }
}
