//
//  PostScreenView.swift
//  justice-for-families
//
//  Created by Joshua Chan on 12/4/20.
//

//https://www.youtube.com/watch?v=yTWPsC6DJFo
//Post ID should get passed to this screen

import SwiftUI
import Combine

class CommentsNetworkManager: ObservableObject {
    var didChange = PassthroughSubject<CommentsNetworkManager, Never>()
    private var postId: String
    
    @Published var comments = [Comment]() {
        didSet {
            didChange.send(self)
        }
    }
    
    init(postId: String) {
        self.postId = postId
        fetchComments(postId: postId)
    }
    
    private func fetchComments(postId: String) {
        Network.getComments(forPostID: postId,
                            completionHandler: {(comments) in
                                self.comments = comments
                                comments.forEach({
                                    print($0)
                                })
                            })
    }
}

struct PostView: View {
    
    var post: Post

    @ObservedObject var networkManager: CommentsNetworkManager
    
    init(post: Post) {
        self.post = post
        self.networkManager = CommentsNetworkManager(postId: post.DecodedPost._id)
        
    }
        
    var body: some View {
        List {
            Section(header: PostHeader(post: post)) {
                ForEach(networkManager.comments) { i in
                    CommentCell(comment: i)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.white)
                }
            }.textCase(.none)
        }.listStyle(GroupedListStyle()) // Important, so that the header scrolls with the list
    }
    
}

struct CommentCell: View {
    
    var comment: Comment
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 41, height: 41, alignment: .leading)
            VStack(alignment: .leading) {
                CommentView(comment: comment)
//                HStack(alignment: .top, spacing: 24) {
//                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                        Text("Like")
//                            .font(Font.custom("AvenirNext-Regular", size: 12))
//                            .foregroundColor(J4FColors.secondaryText)
//                    })
//                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                        Text("Reply")
//                            .font(Font.custom("AvenirNext-Regular", size: 12))
//                            .foregroundColor(J4FColors.secondaryText)
//                    })
//                }
            }
            
        }
        .frame(height: 120, alignment: .leading)
        .padding(.horizontal, 20)
    }
    
}

struct CommentView: View {
    
    var comment: Comment
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(comment.username)
                .font(J4FFonts.username)
                .foregroundColor(J4FColors.darkBlue)
            Text(comment.text)
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
        PostView(post: Post())
    }
}
*/
