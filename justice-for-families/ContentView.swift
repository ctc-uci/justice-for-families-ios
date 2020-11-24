//
//  ContentView.swift
//  justice-for-families
//
//  Created by Ethan  Nguyen on 10/24/20.
//

import SwiftUI



struct ContentView: View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
