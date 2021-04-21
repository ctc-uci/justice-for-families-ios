//
//  PostRow.swift
//  justice-for-families
//
//  Created by Joshua Chan on 12/4/20.
//

import SwiftUI

struct PostRow: View {
    var post: Post
    @State var isLiked = false;
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
                        Text(post.username)
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
            Text(post.title)
                .fontWeight(.bold)
            Text(post.text)
            Spacer()
            HStack(spacing: 10) {
                Button(action: {
                    let parameters = ["username" : UserDefaults.standard.object(forKey: "LoggedInUser")! ]
                        if isLiked == false {
                            Network.likePost(parameters: parameters)
                            isLiked = true
                        }
                        else{
                            Network.unlikePost(parameters: parameters)
                            isLiked = false
                        }
                    print(parameters["username"]!)
                    print(parameters["postId"]!)
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
/*
struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostRow()
            PostRow()
        }
    }
}*/
