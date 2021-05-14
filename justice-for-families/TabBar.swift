//
//  TabBar.swift
//  justice-for-families
//
//  Created by Sydney Chiang on 1/15/21.
//

import Foundation
import SwiftUI

enum Tab {
    case Tab1
    case Tab2
    case Tab3
}


struct MainView: View{
    @StateObject var model: AuthenticationData
    @State private var currentView: Tab = .Tab1
    @State private var showModal: Bool = false
    
    var body: some View{
        VStack{
            CurrentScreen( model: model ,currentView: $currentView)
            TabBar(currentView: $currentView, showModal: $showModal)
        }
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showModal){
            AddPostView()
        }
    }
}



struct CurrentScreen: View{
    @StateObject var model: AuthenticationData
    @Binding var currentView: Tab
    var body: some View {
        VStack{
            if currentView == .Tab1 {
                HomeFeed()
            } else if currentView == .Tab2 {
                ActivityView(networkManager: ActivityNetworkManager())
            } else {
                UserProfileView(model: model)
            }
        }
    }
}

struct TabBarItem: View{
    @Binding var currentView: Tab
    let imageName: String
    let paddingEdges: Edge.Set
    let tab: Tab
    
    var body: some View{
        VStack(spacing: 0){
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(5)
                .frame(width:50, height:50, alignment: .center)
                .foregroundColor(currentView == tab ? J4FColors.lightBlue : J4FColors.black)
                .cornerRadius(6)
        }
        .frame(width: 100, height: 50)
        .onTapGesture{ currentView = tab }
//        .padding(paddingEdges, 15)
    }
}

struct TabBar: View{
    @Binding var currentView: Tab
    @Binding var showModal: Bool
    
    var body: some View{
        HStack{
            Spacer()
            TabBarItem(currentView: $currentView, imageName: "house.fill", paddingEdges: .leading, tab: .Tab1)
            Spacer()
            TabBarItem(currentView: $currentView, imageName: "bell", paddingEdges: .trailing, tab: .Tab3)
            ShowModalTabBarItem(radius: 40){ showModal.toggle() }
            Spacer()
            TabBarItem(currentView: $currentView, imageName: "person.fill", paddingEdges: .trailing, tab: .Tab2)
            Spacer()
        }
        .frame(minHeight: 40)
    }
    
}

public struct ShowModalTabBarItem: View{
    let radius: CGFloat
    let action: () -> Void
    
    public init(radius: CGFloat, action: @escaping() -> Void){
        self.radius = radius
        self.action = action
    }
    
    public var body: some View{
        VStack(spacing: 0){
            Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: radius, height: radius, alignment: .center)
                .foregroundColor(J4FColors.orange)
                .background(Color(.white))
                .cornerRadius(radius/2)

        }
        .frame(width: radius, height: radius)
        .onTapGesture(perform: action)
    }
}

//struct Main: View {
//    @StateObject var model = AuthenticationData()
//    @State var newPostPresented = false
//    @State var previouslySelectedTab = -1
//    @State var selectedTab = 0
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            HomeFeed(networkManager: NetworkManager())
//                .tabItem({
//                    Image("home")
//                })
//            ActivityView(networkManager: ActivityNetworkManager())
//                .tabItem({
//                    Image("bell")
//                })
//            SheetPresenter(isPresentingSheet: $newPostPresented, content: AddPostView())
//                .tabItem({
//                    Text("ADD POST")
//                })
//            UserProfileView(model: model)
//                .tabItem({
//                    Image("person")
//                })
//        }
//    }
//}
