//
//  NavBar.swift
//  justice-for-families
//
//  Created by Alvin Chen on 1/12/21.
//



//TabView implementation of navbar, in case a default implementation is needed
import SwiftUI

struct NavBar: View {
    var body: some View {
        TabView {
                    Text("Search Tab")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .tabItem {
                            Image(systemName: "magnifyingglass").font(.system(size: 20))
                                .imageScale(.large)
                        }
                    Text("Home Tab")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .tabItem {
                            Image(systemName: "plus.circle").font(.system(size: 20))
                                .imageScale(.large)
                                
                        }
                    Text("Profile Tab")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .tabItem {
                            Image(systemName: "square").font(.system(size: 20))
                                .imageScale(.large)
                        }
                }.onAppear() {
                    UITabBar.appearance().barTintColor = .darkGray
                    }
                .accentColor(.white)
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
