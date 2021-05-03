//
//  Activity.swift
//  justice-for-families
//
//  Created by Jules Labador on 5/1/21.
//

import Foundation

struct Activity: Decodable {
    var comments: [ActivityComment]
}

struct ActivityComment: Decodable, Hashable {
    var postID: String
    var postUsername: String
    var postTitle: String
    var postText: String
    var commentID: String
    var commentUsername: String
    var commentDatePosted: String
    var commentText: String
}

extension ActivityComment: Identifiable {
    var id: String { return commentID}
}

//{"comments":
//    [
//    {"postID":"6089eacb9ad8890004fee450","postUsername":"nguyenethan01@gmail.com","postTitle":"Testing long posts","postText":"This post\nshould have\nmore than\n4 lines\nin its\ntext body","commentID":"608db7cc1044d70004c90403","commentUsername":"jlabador@uci.edu","commentDatePosted":"2021-05-01T20:19:24.811Z","commentText":"Test test test test est"}
//    ]
//}
