//
//  ActivityCell.swift
//  justice-for-families
//
//  Created by Jules Labador on 4/28/21.
//

import SwiftUI

struct ActivityCell: View {
    
    var comment = ActivityComment(postID: "", postUsername: "ME", postTitle: "TITLE", postText: "TEXT", commentID: "", commentUsername: "ME ME ME", commentDatePosted: "", commentText: "")
    
    init(_ c: ActivityComment) {
        self.comment = c
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white)
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 41, height: 41, alignment: .leading)
                
                VStack(alignment: .leading){
                    Text("\(Network.getDisplayUsername(fromUsername: comment.commentUsername)) commented on one of your posts")
                        .font(J4FFonts.postText)
                        .multilineTextAlignment(.leading)
                    
                    let isoDate = comment.commentDatePosted
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


                

                Spacer()
            }
            .padding(20)


        }
        
    }
}

