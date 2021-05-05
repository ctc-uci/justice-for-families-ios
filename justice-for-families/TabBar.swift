//
//  TabBar.swift
//  justice-for-families
//
//  Created by Sydney Chiang on 1/15/21.
//

import Foundation
import SwiftUI


struct Main: View {
    @StateObject var model = AuthenticationData()
    @State var newPostPresented = false
    var body: some View {
        TabView {
            HomeFeed(networkManager: NetworkManager())
                .tabItem({
                    Text("HOME")
                })
            ActivityView(networkManager: ActivityNetworkManager())
                .tabItem({
                    Text("ACTIVITY")
                })
            SheetPresenter(presentingSheet: $newPostPresented, content: AddPostView())
                .tabItem({
                    Text("ADD POST")
                })
            UserProfileView(model: model)
                .tabItem({
                    Text("PROFILE")
                })
            
        }
    }
}
