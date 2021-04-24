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
    @State private var commentText: String = ""
    @State private var placeholderString: String = "hello"
    var post: Post
    /*
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(red: 196/255.0, green: 215/255.0, blue: 235/255.0, alpha: 1.0)
        
    }*/
        
    var body: some View {
        VStack{
                    List {
                        Section(header: PostHeader(post: post)) {
                            ForEach(1..<20) { i in
                                CommentCell()
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
                                    if self.commentText == placeholderString {
                                        self.commentText = ""
                                      
                                                    }
                                                }
                            Text(commentText)
                           
                                .opacity(0)
                                .padding(.all, 8) // <- This will solve the issue if it is in the same ZStack
                        
                                    }
                        // the button triggers creating post
                        
                        Button(action: {let parameters = ["text" : commentText,
                                                          "username":  UserDefaults.standard.string(forKey: "LoggedInUser")!,
                                                          "numLikes":0,
                                                          "postId": post.DecodedPost._id, "_id:": post.DecodedPost._id
                           
                            ] as [String : Any]
                        Network.createNewComment(parameters: parameters,postID: post.DecodedPost._id)}) {
                            
                            Text("Post")
                                .font(J4FFonts.postTitle)
                            
                                    }
                    }.frame(idealHeight: CGFloat(10), maxHeight: CGFloat(50)).padding(.horizontal)
                }

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
                
                Text(post.anonymous  == false ? "@\(post.username)" : "anonymous")
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
        PostView()
    }
}
*/
