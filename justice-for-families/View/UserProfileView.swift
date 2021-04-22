//
//  UserProfileView.swift
//  justice-for-families
//
//  Created by Sydney Chiang on 2/11/21.
//

import Foundation
import SwiftUI
import Combine

struct profileColors{
    static let primaryColor = Color(.sRGB, red: 16/255.0, green: 83/255.0, blue: 110/255.0, opacity: 1)
    static let primaryColorOpaque = Color(.sRGB, red: 16/255.0, green: 83/255.0, blue: 110/255.0, opacity: 0.75)
    
    static let primaryColor2 = Color(.sRGB, red: 25/255.0, green: 118/255.0, blue: 157/255.0, opacity: 1)
    static let primaryColor3 = Color(.sRGB, red: 50/255.0, green: 83/255.0, blue: 98/255.0, opacity: 1)
    static let accentColor = Color(.sRGB, red: 252/255.0, green: 129/255.0, blue: 97/255.0, opacity: 1)
}

struct UserProfileView: View{
    @StateObject var model: AuthenticationData
    var body: some View{
        NavigationView{
            ScrollView{
                UserCell()
                    .navigationBarTitle(UserDefaults.standard.string(forKey: "LoggedInEmail")!, displayMode: .inline)
                    .navigationBarItems(trailing:
                    Menu("...") {
                        Button("Logout", action: {model.logout()})

                    })
            }
        }.navigationBarHidden(true)
    }

}


struct UserCell: View{
    var body: some View{
        VStack{
            BioView()
            OwnPosts()
//            PostView()
            
        }

    }
    
}

struct BioView : View {

    var body: some View{
        HStack{
            Image(systemName: "person.circle").font(.system(size: 90, weight: .regular))
            VStack(alignment: .leading){
                Text(UserDefaults.standard.string(forKey: "LoggedInEmail")!)
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


/*
struct HButtonView : View{
    let tabs = ["Posts", "Activity"]
    @State var isPostViewToggled = true
    @State var isActivityViewToggled = false
    var body: some View{
        HStack{
            ForEach(tabs, id: \.self) { tab in
                HStack{
                    Spacer()
                    Button(action: {

                    }) {
                        Text(tab)
                            .font(.custom("Poppins-Medium", size: 16))
                            .foregroundColor(profileColors.primaryColor3)
                    }
                    Spacer()
                }

                
            }
        }.padding(.top)

    }
}*/

struct OwnPosts : View{
    @ObservedObject var networkManager = ProfileNetworkManager()
    private let posts: [Post] = []
    
    var body: some View{
        VStack {
            ForEach(networkManager.posts) { p in
                FeedCell(post: p)
                    .listRowBackground(J4FColors.background)
            }
        }.textCase(.none)
        .listStyle(SidebarListStyle())
        .padding(.top)
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
        Network.getPost(fromUsername: UserDefaults.standard.string(forKey: "LoggedInUser")!) {
            (posts) in self.posts = posts
        }
    }
    
    
    
}

//struct ProfilePostView : View{
//    var body: some View{
//        PostView()
//    }
//}

/*
struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
*/
