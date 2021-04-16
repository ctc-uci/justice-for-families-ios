//
//  PostRow.swift
//  justice-for-families
//
//  Created by Joshua Chan on 12/4/20.
//

import SwiftUI

struct PostRow: View {
    @State var isLiked = false;
    // var post: PostModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image("defaultProfilePicture")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                
                    
                VStack(alignment: .leading, spacing: 10) {
                    Text("Tag")
                        .foregroundColor(.gray)
                    HStack(spacing: 10) {
                        Text("Username")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        Text("2h ago")
                    }
                }
                Spacer()
                Button(action: {}){
                    Text("+ Join")
                        .foregroundColor(.white)
                        .padding()
                        .background(Capsule().fill(Color.gray))
                }
            }
            Text("Post title")
                .fontWeight(.bold)
            Text("This is a test. This is the post details. Feel free to make any changes.")
            Spacer()
            HStack(spacing: 10) {
                Button(action: {
                    let parameters = [
                                          "username" : "buyHighSellLow",
                                        "_id" : "6025c6ef604b72766a49980d"
                                         ]
                        if isLiked == false {
                            Network.likePost(parameters: parameters)
                            isLiked = true;
                        }
                        else{
                            Network.unlikePost(parameters: parameters)
                            isLiked = false;
                        }
                })
                {
                    if isLiked == true
                    {
                        Text("Liked")
                    }
                    else
                    {
                        Text("Like")
                    }
                }
                Spacer()
                Button(action: {}){
                    Text("Comment")
                }
                Spacer()
                Button(action: {}){
                    Text("Share")
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostRow()
            PostRow()
        }
    }
}
