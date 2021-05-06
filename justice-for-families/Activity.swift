//
//  Activity.swift
//  justice-for-families
//
//  Created by Jules Labador on 5/1/21.
//

import Foundation

struct ActivityDecodable: Decodable {
    var comments: [ActivityComment]
}

struct Activity: Identifiable, Decodable {
    var id = UUID()
    var comments: [ActivityComment]
}

struct ActivityComment: Codable, Hashable {
    var postID:             String = ""
    var postUsername:       String = ""
    var postTitle:          String = ""
    var postText:           String = ""
    var commentID:          String = ""
    var commentUsername:    String = ""
    var commentDatePosted:  String = ""
    var commentText:        String = ""    
}

extension ActivityComment: Identifiable {
    var id: String { return commentID}
}
