//
//  justice_for_familiesApp.swift
//  justice-for-families
//
//  Created by Ethan  Nguyen on 10/24/20.
//

import SwiftUI

@main
struct justice_for_familiesApp: App {
    @StateObject var model = AuthenticationData()
    var body: some Scene {
        WindowGroup {
            
            if (UserDefaults.standard.string(forKey: "LoggedInUser") != nil) {
                MainView(model: model)
            }
            else{
                LoginView()
            }
            
            
        }
    }
}
