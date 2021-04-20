//
//  PostScreenView.swift
//  justice-for-families
//
//  Created by Joshua Chan on 12/4/20.
//

//https://www.youtube.com/watch?v=yTWPsC6DJFo
//Post ID should get passed to this screen

import SwiftUI

struct PostView: View {
    
    var post: Post = Post(anonymous: false, datePosted: "", createdAt: "", updatedAt: "", numComments: 5, tags: [], title: "This is the headline, you must click through to access the rest of this post", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", username: "iamspeed")
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(red: 196/255.0, green: 215/255.0, blue: 235/255.0, alpha: 1.0)
        
    }
        
    var body: some View {
        List {
            Section(header: PostHeader(post: post)) {
                ForEach(1..<20) { i in
                    CommentCell()
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.white)
                }
            }.textCase(.none)
        }.listStyle(GroupedListStyle()) // Important, so that the header scrolls with the list
    }
}

struct CommentCell: View {
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 41, height: 41, alignment: .leading)
            VStack(alignment: .leading) {
                CommentView()
                HStack(alignment: .top, spacing: 24) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Like")
                            .font(Font.custom("AvenirNext-Regular", size: 12))
                            .foregroundColor(J4FColors.secondaryText)
                    })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Reply")
                            .font(Font.custom("AvenirNext-Regular", size: 12))
                            .foregroundColor(J4FColors.secondaryText)
                    })
                }
            }
            
        }
        .frame(height: 120, alignment: .leading)
        .padding(.horizontal, 20)
    }
    
}

struct CommentView: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("@blackpinkjinsoo")
                .font(J4FFonts.username)
                .foregroundColor(J4FColors.darkBlue)
            Text("Very cool!")
                .font(J4FFonts.postText)
                .foregroundColor(J4FColors.secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, 16)
        .background(J4FColors.lightGray)
        .cornerRadius(8.0)
        
    }
}

struct PostHeader: View {
    
    var post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 41, height: 41, alignment: .leading)
                
                Text("@\(post.username)")
                    .font(J4FFonts.username)
                    .foregroundColor(J4FColors.darkBlue)
                Text("3h")
                    .font(J4FFonts.postText)
                    .foregroundColor(J4FColors.secondaryText)
                Spacer()
            }
            Spacer(minLength: 16)
            Text(post.title)
                .font(J4FFonts.postTitle)
                .foregroundColor(J4FColors.darkBlue)
                .multilineTextAlignment(.leading)
            Spacer(minLength: 16)
            Text(post.text)
                .font(J4FFonts.username)
                .foregroundColor(J4FColors.black)
                .multilineTextAlignment(.leading)
            Spacer(minLength: 16)
            FeedCellInteractButtons(numLikes: 5, numComments: post.numComments)
            
        }
        .padding(20)
        .frame(minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .topLeading)
        .background(Color.white)
    }
}
/*
struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
*/
