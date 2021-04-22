//
//  Post.swift
//  justice-for-families
//
//  Created by Jules Labador on 2/21/21.
//

import Foundation

struct DecodedPost: Decodable {
    
    var __v: Int
    var _id: String
     
    let anonymous: Bool
    
    let datePosted: String
    let createdAt: String
    let updatedAt: String

    let numComments: Int
    
    let tags: [String]

    let title: String
    let text: String
    let username: String
    
}

struct Post: Identifiable {
    
    let id = UUID()
    let anonymous: Bool
    
    let datePosted: String
    let createdAt: String
    let updatedAt: String

    let numComments: Int
    
    let tags: [String]

    let title: String
    let text: String
    let username: String
}
