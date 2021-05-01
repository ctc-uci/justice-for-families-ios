//
//  ActivityView.swift
//  justice-for-families
//
//  Created by Jules Labador on 4/28/21.
//

import SwiftUI
import Combine

class ActivityNetworkManager: ObservableObject {
    
    var didChange = PassthroughSubject<ActivityNetworkManager, Never>()
    var username = UserDefaults.standard.string(forKey: "LoggedInUser") ?? ""
    
    @Published var activity = [Activity]() {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        fetchActivity()
    }
    
    public func fetchActivity() {
        activity.append(Activity())
        activity.append(Activity())
        activity.append(Activity())
        activity.append(Activity())
        activity.append(Activity())
        activity.append(Activity())
    }
}

struct ActivityView: View {
    
    @ObservedObject var networkManager = ActivityNetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.activity) { a in
                ActivityCell(activity: a)
            }
            .navigationBarTitle("Activity")
        }
        // Goodbye 5head :)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
