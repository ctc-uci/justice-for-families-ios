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

struct UIUserProfileFeed: View{
    @ObservedObject var networkManager: ProfileNetworkManager
    @StateObject var model: AuthenticationData
    var body: some View{
   
        ScrollView{
            BioView()
            OwnPosts()
                
        }.navigationBarTitle(UserDefaults.standard.string(forKey: "LoggedInUser") ?? "", displayMode: .inline)
        .navigationBarItems(trailing:
        Menu("...") {
            Button("Logout", action: {model.logout()})

        })

    }

}

struct BioView : View {

    var body: some View{
        HStack{
            Image(systemName: "person.circle").font(.system(size: 90, weight: .regular))
            VStack(alignment: .leading){
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

struct OwnPosts : View{
    @ObservedObject var networkManager = ProfileNetworkManager()
    private let posts: [Post] = []
    
    var body: some View{
        Section(header: SectionHeader(title: "Posts")) {
            ForEach(networkManager.posts) { p in
                NavigationLink(destination: PostView(post: p)){
                    FeedCell(post: p)
                        .listRowBackground(J4FColors.background)
                }
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
        Network.getPost(fromUsername: UserDefaults.standard.string(forKey: "LoggedInUser") ?? "") {
            (posts) in self.posts = posts.reversed()
        }
    }
    
}

struct UserProfileView: View {
    @StateObject var model: AuthenticationData
    var body: some View {
        GeometryReader{
            geometry in
            NavigationView{
                UserProfileViewHelper(width: geometry.size.width, height: geometry.size.height, model: model)
            }.navigationBarHidden(true)
        }
    }
}

struct UserProfileViewHelper: UIViewRepresentable {
    var width : CGFloat
    var height : CGFloat
    @StateObject var model: AuthenticationData
    var networkManager = ProfileNetworkManager()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, model: networkManager)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let control = UIScrollView()
        control.refreshControl = UIRefreshControl()
        control.refreshControl?.addTarget(context.coordinator, action:
            #selector(Coordinator.handleRefreshControl),
                                          for: .valueChanged)
        
        let childView = UIHostingController(rootView: UIUserProfileFeed(networkManager: networkManager, model: model))
            childView.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
            
            control.addSubview(childView.view)
            return control
        }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {}
    
    class Coordinator: NSObject {
            var control: UserProfileViewHelper
        var model : ProfileNetworkManager
        init(_ control: UserProfileViewHelper, model: ProfileNetworkManager) {
                self.control = control
                self.model = model
            }
    @objc func handleRefreshControl(sender: UIRefreshControl) {
                sender.endRefreshing()
                model.getPosts()
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
