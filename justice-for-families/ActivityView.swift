//
//  ActivityView.swift
//  justice-for-families
//
//  Created by Jules Labador on 4/28/21.
//

import SwiftUI
import Combine



struct ActivityView: View {
    @State private var isShowing = false
    @State private var showNoActivity = false
    @ObservedObject var networkManager: ActivityNetworkManager
    @StateObject var model: AuthenticationData
    var isTabView : Bool
    
    var body: some View {
                
        NavigationView {
            List{
                ForEach(networkManager.comments){ c in
                    NavigationLink(destination: PostView(postID: c.postID, model: model)) {
                        ActivityCell(c)
                            .background(J4FColors.background)
                    }
                }

                noActivityMessage()

            }
            .background(J4FColors.background)
            .navigationBarHidden(!isTabView)
            .navigationBarTitle("Activity")
                
        }
        .background(J4FColors.background)
        .navigationBarTitle("Activity")
        .navigationBarHidden(isTabView)
        .pullToRefresh(isShowing: $isShowing) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
               networkManager.fetchActivity()
               self.isShowing = true
            }
        }
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
            self.comments = a.comments.reversed()
        }
    }
}
