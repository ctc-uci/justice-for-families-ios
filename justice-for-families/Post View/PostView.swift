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
    private var postID: String
    
    @Published var comments = [Comment]() {
        didSet {
            didChange.send(self)
        }
    }
    
    init(postID: String = "") {
        self.postID = postID
//        print("🟡 PostView init with ID: \(postID)")
//        fetchComments()
    }
    
    
    func fetchComments() {
        Network.getComments(forPostID: self.postID, completionHandler: { (comments) in
            self.comments = comments
        })
    }
}

class PostModel: ObservableObject {
    
    @ObservedObject var networkManager: CommentsNetworkManager
    var post: Post!
    
    init(post: Post!) {
        self.post = post
        self.networkManager = CommentsNetworkManager(postID: post.decodedPost._id)
        self.networkManager.fetchComments()
    }
    
    init(postID: String) {
        // Download the post
        self.networkManager = CommentsNetworkManager(postID: postID)
        self.networkManager.fetchComments()
        
        Network.getPost(fromPostID: postID) { post in
            self.post = post
        }
    }
    
}

struct PostView: View {
    @State private var commentText: String = ""
    @State private var placeholderString: String = "hello"
    @StateObject var model: AuthenticationData
    
    var postModel: PostModel
    
    init(post: Post?, model: AuthenticationData) {
        self.postModel = PostModel(post: post)
        self._model = StateObject(wrappedValue: model)
    }
    
    init(postID: String, model: AuthenticationData) {
        self.postModel = PostModel(postID: postID)
        self._model = StateObject(wrappedValue: model)
    }
    
    
        
    var body: some View {
        VStack {
            List {
                Section(header: PostHeader(post: postModel.post, model: model)) {
                    ForEach(postModel.networkManager.comments) { i in
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
                                      "postId": postModel.post.decodedPost._id,
                                      "_id:": postModel.post.decodedPost._id] as [String : Any]
                    Network.createNewComment(parameters: parameters,postID: postModel.post.decodedPost._id)
                    let newComment = Comment(text: commentText, username: UserDefaults.standard.string(forKey: "LoggedInUser")!, numLikes: 0, postId: postModel.post.decodedPost._id, datePosted: nil, createdAt: nil, updatedAt: nil)
                    postModel.networkManager.comments.append(newComment)
                    postModel.post.numComments += 1
                    commentText = ""
                }
                ) {
                    Text("Post")
                        .padding(.horizontal)
                        .background(
                            Capsule(style: .continuous)
                                .fill(J4FColors.reallyLightBlue)
                                )
                                
                        .font(J4FFonts.postTitle)
                        .accentColor(J4FColors.darkBlue)             
                }.disabled(commentText=="")
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
                .frame(width: 35, height: 35, alignment: .leading)
            VStack(alignment: .leading) {
                CommentView(comment: comment)
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
            Text(Network.getDisplayUsername(fromUsername: comment.username))
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
    @StateObject var model: AuthenticationData
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if post.anonymous{
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 41, height: 41, alignment: .leading)
                } else{
                    NavigationLink(destination: UserProfileView(model: model, username: post.username)) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 41, height: 41, alignment: .leading)
                    }
                    
                }


                VStack(alignment: .leading) {
                    HStack {
                        TagCell(tag: post.tags[0])
                        // Checks to see if a second tag exists, then displays another TagCell
                        post.tags.indices.contains(1) == true ? TagCell(tag: post.tags[1]) : nil
                    }
                    HStack {
                        if post.anonymous{
                            Text("anonymous")
                                .font(J4FFonts.username)
                                .foregroundColor(J4FColors.darkBlue)
                                .lineLimit(1)
                        }else{
                            NavigationLink(destination: UserProfileView(model: model, username: post.username)) {
                                Text(Network.getDisplayUsername(fromUsername: post.username))
                                    .font(J4FFonts.username)
                                    .foregroundColor(J4FColors.darkBlue)
                                    .lineLimit(1)
                            }
                        }

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
                .font(J4FFonts.postText)
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
