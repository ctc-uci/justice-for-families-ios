//
//  Comment-2.swift
//  justice-for-families
//
//  Created by Jules Labador on 4/20/21.
//

import Foundation
import UIKit

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

class Comment: Identifiable, ObservableObject {
    
    let id = UUID()
    let text: String
    let username: String
    let numLikes: Int
    let postId: String
    
    let datePosted: String?
    let createdAt: String?
    let updatedAt: String?
    
    @Published var userProfilePicture: UIImage = UIImage(systemName: "person.crop.circle")!
    
    init(text: String, username: String, numLikes: Int, postId: String, datePosted: String?, createdAt: String?, updatedAt: String?) {
        self.text = text
        self.username = username
        self.numLikes = numLikes
        self.postId = postId
        self.datePosted = datePosted
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
}
