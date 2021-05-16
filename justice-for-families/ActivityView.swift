//
//  ActivityView.swift
//  justice-for-families
//
//  Created by Jules Labador on 4/28/21.
//

import SwiftUI
import Combine



struct ActivityView: View {
    
    @ObservedObject var networkManager: ActivityNetworkManager
    @StateObject var model: AuthenticationData
    var isTabView : Bool
    
    var body: some View {
                
        NavigationView {
            List(networkManager.comments) { c in
                NavigationLink(destination: PostView(postID: c.postID, model: model)) {
                    ActivityCell(c)
                        .background(J4FColors.background)
                }
            }
            .background(J4FColors.background)
            .navigationBarHidden(!isTabView)
            .navigationBarTitle("Activity")
            
        }
        .background(J4FColors.background)
        .navigationBarTitle("Activity")
        .navigationBarHidden(isTabView)

    }
}


class ActivityNetworkManager: ObservableObject {
    
    var didChange = PassthroughSubject<ActivityNetworkManager, Never>()
    var username = UserDefaults.standard.string(forKey: "LoggedInUser") ?? ""
    
    @Published var comments = [ActivityComment]() {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        fetchActivity()
    }
    
    public func fetchActivity() {
        Network.getWhatYouMissed { a in
            self.comments = a.comments
        }
    }
}
