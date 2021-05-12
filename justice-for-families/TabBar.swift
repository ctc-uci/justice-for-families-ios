//
//  TabBar.swift
//  justice-for-families
//
//  Created by Sydney Chiang on 1/15/21.
//

import Foundation
import SwiftUI


enum Tab{
    case Tab1
    case Tab2
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
            PopUp()
        }
    }
}



struct CurrentScreen: View{
    @StateObject var model: AuthenticationData
    @Binding var currentView: Tab
    var body: some View{
        VStack{
            if currentView == .Tab1 {
                HomeFeed(model: model)
            }
            else{
                UserProfileView(model: model, username: UserDefaults.standard.string(forKey: "LoggedInUser") ?? "")
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
        .padding(paddingEdges, 15)
    }
}

struct TabBar: View{
    @Binding var currentView: Tab
    @Binding var showModal: Bool
    
    var body: some View{
        HStack{
            TabBarItem(currentView: $currentView, imageName: "house.fill", paddingEdges: .leading, tab: .Tab1)
            Spacer()
            ShowModalTabBarItem(radius: 40){
                showModal.toggle()
            }
            Spacer()
            TabBarItem(currentView: $currentView, imageName: "person.fill", paddingEdges: .trailing, tab: .Tab2)
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



/*
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}*/
