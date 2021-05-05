//
//  Post-2.swift
//  justice-for-families
//
//  Created by Jules Labador on 4/20/21.
//

import Foundation

struct HasLikedResponse: Decodable {
    
    var hasLiked: Bool
}

struct DecodedPost: Decodable {
    
    var __v: Int
    var _id: String
     
    let anonymous: Bool
    
    let datePosted: String
    let createdAt: String
    let updatedAt: String

    let numComments: Int
    let numLikes: Int
    
    let tags: [String]

    let title: String
    let text: String
    let username: String
    
}

class Post: Identifiable, ObservableObject {
    
    let id = UUID()
    var anonymous: Bool = false

    var decodedPost: DecodedPost
    var datePosted: String = ""
    var createdAt: String = ""
    var updatedAt: String = ""

    @Published var numComments: Int = 0
    
    @Published var isLiked: Bool = false
    @Published var numLikes: Int = 0
    
    var tags = [String]()

    var title: String = ""
    var text: String = ""
    var username: String = ""
    
    init(anonymous: Bool, datePosted: String, createdAt: String, updatedAt: String, numComments: Int, numLikes: Int, tags: [String], title: String, text: String, username: String, DecodedPost: DecodedPost) {
        
        self.anonymous = anonymous
        self.datePosted = datePosted
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.numComments = numComments
        self.numLikes = numLikes
        self.tags = tags.map({
            $0.replacingOccurrences(of: "#", with: "")
        })
        self.title = title
        self.text = text
        self.username = username
        self.decodedPost = DecodedPost
    }
    
    // This init() just makes it easier to create an empty Post object
    init() {
        anonymous = false
        datePosted = "Jan 04, 2021"
        createdAt = "Jan 04, 2021"
        updatedAt = "Jan 04, 2021"
        numComments = 0
        numLikes = 0
        tags = ["J4F"]
        title = ""
        text = ""
        username = ""
        decodedPost = DecodedPost(__v: 0, _id: "", anonymous: false, datePosted: "Jan 04, 2021", createdAt: "Jan 04, 2021", updatedAt: "Jan 04, 2021", numComments: 0, numLikes: 0, tags: ["J4F"], title: "", text: "", username: "")
    }
}
