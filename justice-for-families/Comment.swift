//
//  Comment.swift
//  justice-for-families
//
//  Created by Jules Labador on 2/21/21.
//

import Foundation

struct DecodedComment: Decodable {
    
    var __v: Int
    var _id: String
    
    let text: String
    let username: String
    let numLikes: Int
    let postId: String
    
    let datePosted: String
    let createdAt: String
    let updatedAt: String
    
}

struct Comment: Identifiable {
    
    let id = UUID()    
    let text: String
    let username: String
    let numLikes: Int
    let postId: String
    
    let datePosted: String
    let createdAt: String
    let updatedAt: String
}
