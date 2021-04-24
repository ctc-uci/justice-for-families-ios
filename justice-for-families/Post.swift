//
//  Post-2.swift
//  justice-for-families
//
//  Created by Jules Labador on 4/20/21.
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
//    let numLikes: Int
    
    let tags: [String]

    let title: String
    let text: String
    let username: String
    
}

class Post: Identifiable, ObservableObject {
    
    let id = UUID()
    var anonymous: Bool = false
    
    var datePosted: String = ""
    var createdAt: String = ""
    var updatedAt: String = ""

    @Published var numComments: Int = 0
    @Published var numLikes: Int = 0
    
    var tags = [String]()

    var title: String = ""
    var text: String = ""
    var username: String = ""
    
    init(anonymous: Bool, datePosted: String, createdAt: String, updatedAt: String, numComments: Int, tags: [String], title: String, text: String, username: String) {
        
        self.anonymous = anonymous
        self.datePosted = datePosted
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.numComments = numComments
        self.tags = tags
        self.title = title
        self.text = text
        self.username = username
        
    }
}
