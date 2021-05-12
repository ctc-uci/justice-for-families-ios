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
                Text("\(comment.commentUsername) commented on one of your posts")
                    .font(J4FFonts.postText)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(20)
        }
        
    }
}

//struct ActivityCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityCell(ActivityComment())
//    }
//}
