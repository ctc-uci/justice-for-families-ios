//
//  MainView.swift
//  justice-for-families
//
//  Created by Jules Labador on 5/17/21.
//

import Foundation
import SwiftUI

struct MainView: View{
    @StateObject var model: AuthenticationData
    @State private var currentView: Tab = .Tab1
    @State private var showModal: Bool = false
    
    var body: some View{
        VStack{
            CurrentScreen( model: model, currentView: $currentView)
            TabBar(currentView: $currentView, showModal: $showModal)
        }
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showModal){
            AddPostView()
        }
    }
}
