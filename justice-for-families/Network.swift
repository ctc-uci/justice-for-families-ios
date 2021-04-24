//
//  Network.swift
//  justice-for-families
//
//  Created by Jules Labador on 1/29/21.
//

import Foundation
import Alamofire

struct Network {
    
    static let baseURL = "https://j4f-backend.herokuapp.com"
    static func unlikePost(parameters:[String: Any]) {
        
        guard let url = URL(string: "\(baseURL)/likes/unlike") else { return }
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { (response) in

            switch response.result {

            case .success(_):
                guard let json = response.value else { return }
                print(json)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    static func likePost(parameters:[String: Any]) {
        
        guard let url = URL(string: "\(baseURL)/likes/like") else { return }
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { (response) in

            switch response.result {

            case .success(_):
                guard let json = response.value else { return }
                print(json)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    
    static func createNewPost(parameters: [String: Any]) {
        guard let url = URL(string: "\(self.baseURL)/posts/create") else {
            return
        }
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { (response) in
            switch response.result {
            case .success(_):
                if let json = response.value {
                    print(json)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func createNewComment(parameters: [String: Any], postID: String) {
        guard let url = URL(string: "\(self.baseURL)/\(postID)/comments/create") else {
            print("failed to connect to endpoint")
            return
        }
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { (response) in
            switch response.result {
            case .success(_):
                if let json = response.value {
                    print(json)
                    print("LETS GOOOOOOOOOOO")
                }
            case .failure(let error):
                print("ruh roh, error:")
                print(error)
            }
        }
    }

    static func fetchAllPosts(completionHandler: @escaping (_ posts: [Post]) -> Void) {
        guard let url = URL(string: "\(self.baseURL)/posts") else {
            return
        }
        
        AF.request(url, method: .get).responseString { (response) in

            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                do {
                    let decodedPosts = try JSONDecoder().decode([DecodedPost].self, from: data)
                    let posts = decodedPosts.map { Post(anonymous: $0.anonymous, datePosted: $0.datePosted, createdAt: $0.createdAt, updatedAt: $0.updatedAt, numComments: $0.numComments, tags: $0.tags, title: $0.title, text: $0.text, username: $0.username) }
                    DispatchQueue.main.async { completionHandler(posts) }
                    
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
                
            case .failure(let error):
                print("🔥 \(error)")
            }
        }
        
    }
    
    static func getPost(fromUsername username: String) {
        guard let url = URL(string: "\(self.baseURL)/posts/username/\(username)") else {
            return
        }
        AF.request(url, method: .get).responseString { (response) in
            switch response.result {
            case .success(_):
                if let json = response.value {
                    print(json)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getPost(fromDate date: Date) {
        
    }
    
    static func getComments(forPostID postID: String, completionHandler: @escaping (_ comments: [Comment]) -> Void) {
        guard let url = URL(string: "\(self.baseURL)/comments/post/\(postID)") else {
            return
        }
        AF.request(url, method: .get).responseString { (response) in

            switch response.result {

            case .success(_):
                guard let data = response.data else { return }
                    
                do {
                    
                    let decodedComments = try JSONDecoder().decode([DecodedComment].self, from: data)
                    let comments = decodedComments.map { Comment(text: $0.text, username: $0.username, numLikes: $0.numLikes, postId: $0.postId, datePosted: $0.datePosted, createdAt: $0.createdAt, updatedAt: $0.updatedAt) }
                    completionHandler(comments)
                    
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
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}
