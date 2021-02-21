//
//  Network.swift
//  justice-for-families
//
//  Created by Jules Labador on 1/29/21.
//

import Foundation
import Alamofire


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
    let decodedPost: DecodedPost
    
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

struct Network {
    
//    static func createNewPost(parameters: [String: Any]) {
//
//        guard let url = URL(string: "https://j4f-backend.herokuapp.com/posts/create") else {
//            return
//        }
//
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { (response) in
//
//            switch response.result {
//
//            case .success(_):
//                if let json = response.value {
//                    print(json)
//                }
//                break
//            case .failure(let error):
//                print(error)
//                break
//            }
//        }
//    }
    
    static func fetchAllPosts(completionHandler: @escaping (_ posts: [Post]) -> Void) {
        guard let url = URL(string: "https://j4f-backend.herokuapp.com/posts") else {
            return
        }
        
        AF.request(url, method: .get).responseString { (response) in

            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                    
                do {
                    
                    let decodedPosts = try JSONDecoder().decode([DecodedPost].self, from: data)
                    let posts = decodedPosts.map { Post(decodedPost: $0, anonymous: $0.anonymous, datePosted: $0.datePosted, createdAt: $0.createdAt, updatedAt: $0.updatedAt, numComments: $0.numComments, tags: $0.tags, title: $0.title, text: $0.text, username: $0.username) }
                    completionHandler(posts)
                    
                } catch DecodingError.keyNotFound(let key, let context) {
                    Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
                } catch DecodingError.valueNotFound(let type, let context) {
                    Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.typeMismatch(let type, let context) {
                    Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.dataCorrupted(let context) {
                    Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
                } catch let error as NSError {
                    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                }
                
            case .failure(_):
                return
            }
        }
        
    }
    
    static func getPost(fromUsername username: String) {
        guard let url = URL(string: "https://j4f-backend.herokuapp.com/posts/username/\(username)") else {

        case .success(_):
            if let json = response.value {
                print(json)
            }
        case .failure(let error):
            print(error)
        }
    }
    
    
    static func getPost(fromDate date: Date) {
        
    }
    
}
