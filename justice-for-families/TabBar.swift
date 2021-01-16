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

    @State private var currentView: Tab = .Tab1
    @State private var showModal: Bool = false
    
    var body: some View{
        NavigationView{
            VStack{
                CurrentScreen(currentView: $currentView)
                TabBar(currentView: $currentView, showModal: $showModal)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showModal){
            PopUp()
        }
    }
}



struct CurrentScreen: View{
    @Binding var currentView: Tab
    var body: some View{
        VStack{
            if currentView == .Tab1{
                HomeView()
            }
            else{
                ProfileView()
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
                .frame(width:40, height:40, alignment: .center)
                .background(Color(currentView == tab ? .blue : .white).opacity(0.2))
                .foregroundColor(Color(currentView == tab ? .blue : .black))
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
            ShowModalTabBarItem(radius: 55){
                showModal.toggle()
            }
            Spacer()
            TabBarItem(currentView: $currentView, imageName: "person", paddingEdges: .trailing, tab: .Tab2)
        }
        .frame(minHeight: 70)
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
                .foregroundColor(Color(.systemGray))
                .background(Color(.white))
                .cornerRadius(radius/2)

        }
        .frame(width: radius, height: radius)
        .onTapGesture(perform: action)
    }
}


struct HomeView: View{
    var body: some View{
        VStack{
            Spacer()
            HStack{
                Spacer()
                Text("Home Tab")
                Spacer()
            }
            Spacer()
        }
        .navigationBarTitle("Home Tab")
    }
}




struct ProfileView: View{
    var body: some View{
        VStack{
            Spacer()
            HStack{
                Spacer()
                Text("Profile Tab")
                Spacer()
            }
            Spacer()
        }
        .navigationBarTitle("Profile Tab")
    }
}

struct ScreenModal: View{
    var body: some View{
        VStack{
            Spacer()
            HStack{
                Spacer()
                Text("Modal")
                Spacer()
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}


struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
