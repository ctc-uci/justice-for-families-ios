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
                break
//                guard let json = response.value else { return }
//                print(json)
                
            case .failure(let error):
                break
//                print(error)
                
            }
        }
    }
    
    static func likePost(parameters:[String: Any]) {
        
        guard let url = URL(string: "\(baseURL)/likes/like") else { return }
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { (response) in

            switch response.result {

            case .success(_):
//                guard let json = response.value else { return }
                print("🟢 Succesfully liked post with id: \(parameters["postId"] ?? "__")")
                
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
        guard let url = URL(string: "\(self.baseURL)/comments/\(postID)/comments/create") else {
            print("failed to connect to endpoint")
            return
        }
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { (response) in
            switch response.result {
            case .success(_):
                print("🟢 Comment succesfully created")
//                if let json = response.value {
//                    print(json)
//                    print("LETS GOOOOOOOOOOO")
//                }
            case .failure(let error):
                print("🔴 Error creating comment: \(error)")
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
                    let posts: [Post] = decodedPosts.map {
//                        print("\($0.title) -- \($0.numComments)")
                        return Post(anonymous: $0.anonymous, datePosted: $0.datePosted, createdAt: $0.createdAt, updatedAt: $0.updatedAt, numComments: $0.numComments, numLikes: $0.numLikes, tags: $0.tags, title: $0.title, text: $0.text, username: $0.username, DecodedPost: $0)
                    }

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
    
    static func getPost(fromUsername username: String, completionHandler: @escaping (_ posts: [Post]) -> Void) {
        guard let url = URL(string: "\(self.baseURL)/posts/username/\(username)") else {
            return
        }
        AF.request(url, method: .get).responseString { (response) in

            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                print("🟡", response.result)
                
                do {
                    
                    let decodedPosts = try JSONDecoder().decode([DecodedPost].self, from: data)
                    let posts: [Post] = decodedPosts.map { Post(anonymous: $0.anonymous, datePosted: $0.datePosted, createdAt: $0.createdAt, updatedAt: $0.updatedAt, numComments: $0.numComments, numLikes: $0.numLikes, tags: $0.tags, title: $0.title, text: $0.text, username: $0.username, DecodedPost: $0) }
                    

                    posts.forEach({ p in
                        Network.hasLiked(forPostID: p.decodedPost._id, username: username) { (result) in
                            switch result {
                            case .success(let isLiked):
                                print("🟡 (\(p.decodedPost._id)) -- Has liked \(p.title)? - \(isLiked)")
                                p.isLiked = isLiked
                            case .failure(_):
                                print("🔴 Error trying to check if logged in user has liked post: \(p.decodedPost._id)")
                            }
                        }
                    })
                  
                    DispatchQueue.main.async {
                        completionHandler(posts)
                    }
                    
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
    
 
    static func getLikedPosts(fromUsername username: String, completionHandler: @escaping (_ posts: [Post]) -> Void) {
        let parameters : [String: String] = ["username": username]
        guard let url = URL(string: "\(self.baseURL)/likes/byUser?username=\(username)") else {
            return
        }

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { (response) in

            switch response.result {
            case .success(_):
                guard let data = response.data else { return }

                do {
                    let decodedPosts = try JSONDecoder().decode([DecodedPost].self, from: data)
                    let posts: [Post] = decodedPosts.map { Post(anonymous: $0.anonymous, datePosted: $0.datePosted, createdAt: $0.createdAt, updatedAt: $0.updatedAt, numComments: $0.numComments, numLikes: $0.numLikes, tags: $0.tags, title: $0.title, text: $0.text, username: $0.username, DecodedPost: $0) }

                    posts.forEach({ p in
                        Network.hasLiked(forPostID: p.decodedPost._id, username: username) { (result) in
                            switch result {
                            case .success(let isLiked):
                                print("🟡 (\(p.decodedPost._id)) -- Has liked \(p.title)? - \(isLiked)")
                                p.isLiked = isLiked
                            case .failure(_):
                                print("🔴 Error trying to check if logged in user has liked post: \(p.decodedPost._id)")
                            }
                        }

                    })

                    DispatchQueue.main.async {
                        completionHandler(posts)
                    }

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
    
    static func getPost(fromDate date: Date) {
        
    }
    
    static func getPost(fromPostID postID: String, completionHandler: @escaping (_ posts: Post) -> Void) {
        
        guard let url = URL(string: "\(self.baseURL)/posts/id") else { return }
        let parameters = ["postId": postID] as [String : String]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { (response) in

            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                    
                do {
                    
                    let decodedPosts = try JSONDecoder().decode(DecodedPost.self, from: data)//error seems to be coming from this line
                    let posts: Post =   Post(anonymous: decodedPosts.anonymous, datePosted: decodedPosts.datePosted, createdAt: decodedPosts.createdAt, updatedAt: decodedPosts.updatedAt, numComments: decodedPosts.numComments, numLikes: decodedPosts.numLikes, tags: decodedPosts.tags, title: decodedPosts.title, text: decodedPosts.text, username: decodedPosts.username, DecodedPost: decodedPosts)
                    
                    /*
                    posts.forEach({ p in
                        AF.request(URL(string: "\(self.baseURL)/\(p.DecodedPost._id)/user/\(UserDefaults.standard.string(forKey: "LoggedInUser")!)/hasLiked")!, method: .get).responseString { response in
                            
                        }
                        
                    })*/
                    DispatchQueue.main.async {
                        completionHandler(posts)
                    }
                    
                } catch DecodingError.keyNotFound(let key, let context) {
                    Swift.print("🔴 GET POST ERROR: could not find key \(key) in JSON: \(context.debugDescription)")
                } catch DecodingError.valueNotFound(let type, let context) {
                    Swift.print("🔴 GET POST ERROR: could not find type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.typeMismatch(let type, let context) {
                    Swift.print("🔴 GET POST ERROR: type mismatch for type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.dataCorrupted(let context) {
                    Swift.print("🔴 GET POST ERROR: data found to be corrupted in JSON: \(context.debugDescription)")
                } catch let error as NSError {
                    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                }
                
            case .failure(let error):
                print("🔥 \(error)")
            }
        }
    }
    
    static func getComments(forPostID postID: String, completionHandler: @escaping (_ comments: [Comment]) -> Void) {
        guard let url = URL(string: "\(self.baseURL)/comments/post/\(postID)") else { return }
        
        AF.request(url, method: .get).responseString { (response) in

            switch response.result {

            case .success(_):
                guard let data = response.data else { return }
                    
                do {
                    let decodedComments = try JSONDecoder().decode([DecodedComment].self, from: data)
                    let comments = decodedComments.map { Comment(text: $0.text, username: $0.username, numLikes: $0.numLikes, postId: $0.postId, datePosted: $0.datePosted, createdAt: $0.createdAt, updatedAt: $0.updatedAt) }
                    DispatchQueue.main.async { completionHandler(comments) }
                    
                } catch DecodingError.keyNotFound(let key, let context) {
                    Swift.print("🔴 GET COMMENTS ERROR: could not find key \(key) in JSON: \(context.debugDescription)\n     for comment ID: \(postID)")
                } catch DecodingError.valueNotFound(let type, let context) {
                    Swift.print("🔴 GET COMMENTS ERROR: could not find type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.typeMismatch(let type, let context) {
                    Swift.print("🔴 GET COMMENTS ERROR: type mismatch for type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.dataCorrupted(let context) {
                    Swift.print("🔴 GET COMMENTS ERROR: data found to be corrupted in JSON: \(context.debugDescription)\n     for comment ID: \(postID)")
                } catch let error as NSError {
                    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                }
                break
            case .failure(let error):
                print("🔴 Error trying to retrieve comments for post ID: \(postID): \(error)")
                break
            }
        }
    }
    
//    j4f-backend.herokuapp.com/posts/:postId/user/:username/hasLiked
    static func hasLiked(forPostID postID: String, username: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "\(self.baseURL)/posts/\(postID)/user/\(username)/hasLiked") else {
            return
        }
        
        AF.request(url, method: .get).responseString { (response) in
            
            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                guard let result = try? JSONDecoder().decode(HasLikedResponse.self, from: data) else { return }
                DispatchQueue.main.async { completion(.success(result.hasLiked)) }
                
            case .failure(let error):
                DispatchQueue.main.async { completion(.failure(error)) }
            }

        }
    }
    

    static func getWhatYouMissed(completionHandler: @escaping (_ posts: Activity) -> Void) {

        var dayComponent = DateComponents()
        dayComponent.day = -2 //two days ago
        let calendar = Calendar.current
        let twoDaysAgo =  calendar.date(byAdding: dayComponent, to: Date())!
        
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = iso8601DateFormatter.string(from: twoDaysAgo)
        let parameters = ["username": UserDefaults.standard.string(forKey: "LoggedInUser")!, "startingFrom": date] as [String : Any]
        
        guard let url = URL(string: "\(baseURL)/activity") else { return }
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { (response) in

            switch response.result {
            
            case .success(_):
//                print("🟡 WYM SUCCESS:", response.result)
                guard let data = response.data else { return }
                do {
                    let activities = try JSONDecoder().decode(Activity.self, from: data)
                    DispatchQueue.main.async { completionHandler(activities) }
                } catch DecodingError.keyNotFound(let key, let context) {
                    Swift.print("🔴 GET WYM ERROR: could not find key \(key) in JSON: \(context.debugDescription)")
                } catch DecodingError.valueNotFound(let type, let context) {
                    Swift.print("🔴 GET WYM ERROR: could not find type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.typeMismatch(let type, let context) {
                    Swift.print("🔴 GET WYM ERROR: type mismatch for type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.dataCorrupted(let context) {
                    Swift.print("🔴 GET WYM ERROR: data found to be corrupted in JSON: \(context.debugDescription)")
                } catch let error as NSError {
                    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                }

            case .failure(let error):
                print(error)
                
            }
        }
    }
}
