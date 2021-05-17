//
//  AuthenticationData.swift
//  justice-for-families
//
//  Created by Joshua Chan on 2/21/21.
//

import Foundation
import Alamofire
class AuthenticationData: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var canLogin: Int? = nil
    
    @Published var username = ""
    @Published var isSignUp = false
    @Published var email_SignUp = ""
    @Published var password_SignUp = ""
    @Published var reEnterPassword = ""
    
    init() {
        if let username = UserDefaults.standard.object(forKey: "LoggedInUser") as? String {
            self.email = username
        }
    }
    
    func logout() {
        resetQueries()
    }
    
    func resetQueries() {
        //resetQueries when switching between login and signup views, when you log out
        email = ""
        password = ""
        canLogin = nil
        username = ""
        email_SignUp = ""
        password_SignUp = ""
        reEnterPassword = ""
        UserDefaults.standard.removeObject(forKey: "LoggedInUser")
    }
    func login(email: String, pass: String) {
        print(email, pass)
        //can also use http://localhost:3000/authentication/login
        //this way is good since it tells you specifically what went wrong(e.g. incorrect user/pass, user not yet confirmed, ...)
        //will need to clone j4f backend repo and activate backend using "node server.js" while in j4f backend repo
        
        guard let url = URL(string: "https://j4f-backend.herokuapp.com/authentication/login") else {
            return
        }
        
        AF.request(url, method: .post, parameters: ["email": email, "password": pass], encoding: JSONEncoding.default).responseString { (response) in

            switch response.result {
                case .success(_):
                    if let httpStatusCode = response.response?.statusCode {
                      switch(httpStatusCode) {
                          case 200:
                            self.email = email
                            self.password = pass
                            UserDefaults.standard.set(self.email, forKey: "LoggedInUser")
                            self.canLogin = 1
                            print("Success")
                          case 500:
                            print("Failure")
                          default:
                            print("Invalid Response Code")
                      }
                    }
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
    
    
    func signup() {
        //can also use http://localhost:3000/authentication/login
        //this way is good since it tells you specifically what went wrong(e.g. incorrect user/pass, user not yet confirmed, ...)
        //will need to clone j4f backend repo and activate backend using "node server.js" while in j4f backend repo
        
        guard let url = URL(string: "https://j4f-backend.herokuapp.com/authentication/register") else {
            return
        }
        
        let passwordRequirement = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{8,}$")
        
        if username.count > 0 && email_SignUp.count > 0 && password_SignUp == reEnterPassword && passwordRequirement.evaluate(with: password_SignUp) {
            print("Valid inputs")
        
            AF.request(url, method: .post, parameters: ["email": email_SignUp, "password": password_SignUp], encoding: JSONEncoding.default).responseString { (response) in

                switch response.result {

                case .success(_):
                    if let httpStatusCode = response.response?.statusCode {
                      switch(httpStatusCode) {
                          case 200:
                            print("Success")
                          case 500:
                            print("Failure")
                          default:
                            print("Invalid Response Code")
                      }
                    }
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
 
        else {
            print("Invalid inputs")
        }
    }
}
