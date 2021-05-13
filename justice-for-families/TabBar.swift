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
    @State var previouslySelectedTab = -1
    @State var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeFeed(networkManager: NetworkManager())
                .tabItem({
                    Image("home")
                })
            ActivityView(networkManager: ActivityNetworkManager())
                .tabItem({
                    Image("bell")
                })
            SheetPresenter(isPresentingSheet: $newPostPresented, content: AddPostView())
                .tabItem({
                    Text("ADD POST")
                })
            UserProfileView(model: model)
                .tabItem({
                    Image("person")
                })
        }
    }
}
