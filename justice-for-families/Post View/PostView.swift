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
        fetchComments()
    }
    
    func fetchComments() {
        Network.getComments(forPostID: self.postId, completionHandler: { (comments) in
            self.comments = comments
        })
    }
}

struct PostView: View {
    @State private var commentText: String = ""
    @State private var placeholderString: String = "hello"
    var post: Post

    @ObservedObject var networkManager: CommentsNetworkManager
    
    init(post: Post) {
        self.post = post
        self.networkManager = CommentsNetworkManager(postId: post.DecodedPost._id)
    }
        
    var body: some View {
        VStack {
            List {
                Section(header: PostHeader(post: post)) {
                    ForEach(networkManager.comments) { i in
                        CommentCell(comment: i)
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.white)
                    }
                }.textCase(.none)
            }.listStyle(GroupedListStyle()) // Important, so that the header scrolls with the list
            
            HStack {
                // this textField generates the value for the composedMessage @State var
                ZStack {
                    TextEditor(text: $commentText)
                        .foregroundColor(self.commentText == placeholderString ? .gray : .primary)
                        .onTapGesture {
                            self.commentText == placeholderString ? self.commentText = "" : nil
                        }
                    Text(commentText)
                        .opacity(0)
                        .padding(.all, 8) // <- This will solve the issue if it is in the same ZStack
                }
                // the button triggers creating post
                
                Button(action: {
                    let parameters = ["text" : commentText,
                                      "username":  UserDefaults.standard.string(forKey: "LoggedInUser")!,
                                      "numLikes":0,
                                      "postId": post.DecodedPost._id,
                                      "_id:": post.DecodedPost._id] as [String : Any]
                    Network.createNewComment(parameters: parameters,postID: post.DecodedPost._id)
                    let newComment = Comment(text: commentText, username: UserDefaults.standard.string(forKey: "LoggedInUser")!, numLikes: 0, postId: post.DecodedPost._id, datePosted: nil, createdAt: nil, updatedAt: nil)
                    networkManager.comments.append(newComment)
                    post.numComments += 1
                    commentText = ""
                }) {
                    Text("Post")
                        .font(J4FFonts.postTitle)
                }
            }.frame(idealHeight: CGFloat(10), maxHeight: CGFloat(50)).padding(.horizontal)
        }


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
                VStack(alignment: .leading) {
                    Text(post.tags[0].first == "#" ? post.tags[0] : "#\(post.tags[0])")
                        .frame(width: nil, height: 12, alignment: .center)
                        .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 8))
                        .background(Color(.sRGB, red: 196/255.0, green: 215/255.0, blue: 235/255.0, opacity: 0.3))
                        .cornerRadius(40)
                        .foregroundColor(J4FColors.darkBlue)
                        .font(J4FFonts.postText)
                    HStack {
                        Text(post.anonymous  == false ? "@\(post.username)" : "anonymous")
                            .allowsTightening(true)
                            .font(J4FFonts.username)
                            .foregroundColor(J4FColors.darkBlue)
                            .lineLimit(1)
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
                        Spacer()
                    }
                }
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
            FeedCellInteractButtons(post: post)
            
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
