//
//  Network.swift
//  justice-for-families
//
//  Created by Jules Labador on 1/29/21.
//

import Foundation
import Alamofire

struct Network {
    
    static func createNewPost(parameters: [String: Any]) {
        
        guard let url = URL(string: "http://localhost:3000/posts/create") else {
            return
        }
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { (response) in

            switch response.result {

            case .success(_):
                if let json = response.value {
                    print(json)
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    static func fetchAllPosts() {
        
    }
    
    static func getPost(fromUsername username: String) {
        guard let url = URL(string: "http://localhost:3000/posts/username/\(username)") else {
            return
        }
        AF.request(url, method: .get).responseString { (response) in

            switch response.result {

            case .success(_):
                if let json = response.value {
                    print(json)
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    static func getPost(fromDate date: Date) {
        
    }
    
}
