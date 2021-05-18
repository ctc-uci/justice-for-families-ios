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
            
            // Depending on if the 'LoggedInUser' key exists in UserDefaults,
            // present either the 'MainView' or 'LoginView'
            if (!model.email.isEmpty ) {
                MainView(model: model)
            } else {
                LoginView(model: model)
            }
            
            
        }
    }
}
