//
//  UserProfileView.swift
//  justice-for-families
//
//  Created by Sydney Chiang on 2/11/21.
//

import Foundation
import SwiftUI
import Combine
import SwiftUIRefresh

struct profileColors {
    
    static let primaryColor = Color(.sRGB, red: 16/255.0, green: 83/255.0, blue: 110/255.0, opacity: 1)
    static let primaryColorOpaque = Color(.sRGB, red: 16/255.0, green: 83/255.0, blue: 110/255.0, opacity: 0.75)
    
    static let primaryColor2 = Color(.sRGB, red: 25/255.0, green: 118/255.0, blue: 157/255.0, opacity: 1)
    static let primaryColor3 = Color(.sRGB, red: 50/255.0, green: 83/255.0, blue: 98/255.0, opacity: 1)
    static let accentColor = Color(.sRGB, red: 252/255.0, green: 129/255.0, blue: 97/255.0, opacity: 1)
}

struct UIUserProfileFeed: View {
    
    @ObservedObject var networkManager: ProfileNetworkManager = ProfileNetworkManager()
    @StateObject var model: AuthenticationData
    @State private var isShowing = false
    
    var body: some View {
   
        List {
            Section(header: BioView()) {
                ForEach(networkManager.posts) { p in
                    FeedCell(post: p)
                        .listRowBackground(J4FColors.background)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .pullToRefresh(isShowing: $isShowing, onRefresh: {
            networkManager.getPosts()
            self.isShowing = false
        })
        .navigationBarTitle(UserDefaults.standard.string(forKey: "LoggedInUser") ?? "", displayMode: .inline)
        .navigationBarItems(trailing:
                                
            Menu("...") {
                Button("Logout", action: {model.logout()
            })
        })

    }

}

struct BioView : View {

    var body: some View {
        HStack {
            Image(systemName: "person.circle").font(.system(size: 90, weight: .regular))
            VStack(alignment: .leading) {
                Text(UserDefaults.standard.string(forKey: "LoggedInUser") ?? "")
                    .font(.custom("Poppins-Medium", size: 19))
                    .foregroundColor(profileColors.primaryColor)
                NavigationLink(destination: EditProfileView()) {
                    Text("Edit Profile")
                        .padding()
                        .frame(width:150, height: 24)
                        .background(profileColors.primaryColor2)
                        .foregroundColor(.white)
                        .cornerRadius(100)
                        
                }
            }
        }
    }
    
}


class ProfileNetworkManager: ObservableObject {
    var didChange = PassthroughSubject<ProfileNetworkManager, Never>()
    
    @Published var posts = [Post]() {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        getPosts()
    }
    
    public func getPosts() {
        Network.getPost(fromUsername: UserDefaults.standard.string(forKey: "LoggedInUser") ?? "") {
            (posts) in self.posts = posts.reversed()
        }
    }
    
}

struct UserProfileView: View {
    @StateObject var model: AuthenticationData
    var body: some View {
        NavigationView {
            UIUserProfileFeed(model: model)
        }
    }
}
