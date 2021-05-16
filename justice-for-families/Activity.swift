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
