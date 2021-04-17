//
//  Home Feed.swift
//  justice-for-families
//
//  Created by Jules Labador on 1/11/21.
//

//2/25 Josh https://betterprogramming.pub/pull-to-refresh-in-swiftui-6604f54a01d5 followed this guide for "pull-to-refresh" feature
//made some kinda heavy changes but essentially just make any changes in the UIFeed struct
//feel free to rearrange functions/ rename stuff
//make "pull-to-refresh" updates in HomeFeedHelper's handleRefreshControl function

import SwiftUI
import Combine

struct Update: Identifiable {
    var id: UUID = UUID()
    var numberOfLikes: Int
    var numberOfComments: Int
}

class NetworkManager: ObservableObject {
    var didChange = PassthroughSubject<NetworkManager, Never>()
    
    @Published var posts = [Post]() {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        fetchPosts()
    }
    
    public func fetchPosts() {
        Network.fetchAllPosts { (posts) in
            DispatchQueue.main.async {
                self.posts = posts
            }
        }
    }
    
}

struct J4FColors {
    
    //static let primaryText = Color("primaryText")
    static let primaryText = Color(.black)
}

struct J4FFonts {
    static let sectionTitle = Font.custom("AvenirNext-Medium", size: 15)
    static let headline = Font.custom("AvenirNext-Medium", size: 15)
    static let button = Font.custom("AvenirNext-Regular", size: 10)
    static let username = Font.custom("AvenirNext-Medium", size: 13)
}



struct UIFeed: View {
    @ObservedObject var networkManager: NetworkManager
    private let posts: [Post] = [
//        Post(id: UUID(), text: "Test 1"),
//        Post(id: UUID(), text: "Test 2"),
//        Post(id: UUID(), text: "Test 3")
    ]
        
    private let updates: [Update] = [
        .init(numberOfLikes: 1, numberOfComments: 1),
        .init(numberOfLikes: 10, numberOfComments: 10),
        .init(numberOfLikes: 100, numberOfComments: 100),
        .init(numberOfLikes: 1000, numberOfComments: 1000),
        .init(numberOfLikes: 1, numberOfComments: 1),
        .init(numberOfLikes: 10, numberOfComments: 10),
        .init(numberOfLikes: 100, numberOfComments: 100),
        .init(numberOfLikes: 1000, numberOfComments: 1000),
        .init(numberOfLikes: 1, numberOfComments: 1),
        .init(numberOfLikes: 10, numberOfComments: 10),
        .init(numberOfLikes: 100, numberOfComments: 100),
        .init(numberOfLikes: 1000, numberOfComments: 1000),
        .init(numberOfLikes: 1, numberOfComments: 1),
        .init(numberOfLikes: 10, numberOfComments: 10),
        .init(numberOfLikes: 100, numberOfComments: 100),
        .init(numberOfLikes: 1000, numberOfComments: 1000),
        .init(numberOfLikes: 1, numberOfComments: 1),
        .init(numberOfLikes: 10, numberOfComments: 10),
        .init(numberOfLikes: 100, numberOfComments: 100),
        .init(numberOfLikes: 1000, numberOfComments: 1000),
        .init(numberOfLikes: 1, numberOfComments: 1),
        .init(numberOfLikes: 10, numberOfComments: 10),
        .init(numberOfLikes: 100, numberOfComments: 100),
        .init(numberOfLikes: 1000, numberOfComments: 1000)
    ]
    
    
    var body: some View {
        List {
            Section(header: WhatYouMissedSectionHeader()) {
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack {
                        ForEach(1..<100) { i in
                            WhatYouMissedCell()
                        }
                    }
                })
            }.textCase(.none)
            
            Section(header: FeedSectionHeader()) {
                ForEach(networkManager.posts) { p in
                    FeedCell(post: p)
                }
            }.textCase(.none)
        }
  
    }
}
    

struct WhatYouMissedSectionHeader: View {
    var body: some View {
        Text("What you missed...")
            .textCase(.none)
            .font(J4FFonts.sectionTitle)
            .foregroundColor(J4FColors.primaryText)
    }
}

struct WhatYouMissedCell: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(Color(.sRGB, red: 103/255.0, green: 154/255.0, blue: 151/255.0, opacity: 0.20))
            VStack {
                Text("Update")
            }
            .padding(20)
        }
        .frame(width: 140, height: 80)
    }
    
}

struct FeedSectionHeader: View {
    var body: some View {
        Text("Feed")
            .textCase(.none)
            .font(J4FFonts.sectionTitle)
            .foregroundColor(J4FColors.primaryText)
    }
}

struct FeedCellInteractButtons: View {
    
    let numLikes: Int
    let numComments: Int
    
    var body: some View {
        HStack {
            
            Button(action: {
                print("Tapped on the like button!")
            }) {
                HStack(alignment: .center) {
                    Image(systemName: "hand.thumbsup")
                    Text("\(self.numLikes)")
                        .font(J4FFonts.button)
                        .foregroundColor(J4FColors.primaryText)
                }
                
            }
            Spacer()
            Button(action: {
                print("Tapped on the comment button!")
            }) {
                HStack(alignment: .center) {
                    Image(systemName: "bubble.left")
                    Text("\(self.numComments)")
                        .font(J4FFonts.button)
                        .foregroundColor(J4FColors.primaryText)
                }
                
            }
            Spacer()
            Button(action: {
                print("Tapped on the like button!")
            }) {
                HStack(alignment: .center) {
                    Image(systemName: "square.and.arrow.up")
                    Text("10 shares")
                        .font(J4FFonts.button)
                        .foregroundColor(J4FColors.primaryText)
                }
                
            }
            
        }
    }
}

struct FeedCell: View {
    
    let post: Post
    
    var body: some View {
        NavigationLink(destination: PostView(post: post)) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.white)
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 41, height: 41, alignment: .leading)
                        
                        Text(post.username)
                            .font(J4FFonts.username)
                            .foregroundColor(J4FColors.primaryText)
                        Spacer()
                    }
                    
                    Spacer(minLength: 16)
                    Text(post.title)
                        .font(J4FFonts.headline)
                        .foregroundColor(J4FColors.primaryText)
                        .multilineTextAlignment(.leading)
                    Spacer(minLength: 16)
                    FeedCellInteractButtons(numLikes: 5, numComments: post.numComments)
                    
                }
                .padding(20)
            }
        }
    }
}

struct HomeFeed: View {
    @ObservedObject var model: AuthenticationData
    @State private var showModal = false
    var body: some View {
        GeometryReader{
        geometry in
        NavigationView{
                HomeFeedHelper(width: geometry.size.width, height: geometry.size.height)
                    .navigationBarBackButtonHidden(true).navigationTitle("J4F")
                    .navigationBarItems(trailing:
                      
                        NavigationLink(destination: LoginView()) {
                            Button(action: {model.logout()}) {
                                Text("Logout")
                            }
                        }
                       
                        
                    )
                                            
                    
            }
        //.navigationBarHidden(true)
        }
    }
}

struct HomeFeedHelper: UIViewRepresentable {
    var width : CGFloat
    var height : CGFloat
    
    var networkManager = NetworkManager()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, model: networkManager)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let control = UIScrollView()
        control.refreshControl = UIRefreshControl()
        control.refreshControl?.addTarget(context.coordinator, action:
            #selector(Coordinator.handleRefreshControl),
                                          for: .valueChanged)
        
        let childView = UIHostingController(rootView: UIFeed(networkManager: networkManager))
            childView.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
            
            control.addSubview(childView.view)
            return control
        }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {}
    
    class Coordinator: NSObject {
            var control: HomeFeedHelper
        var model : NetworkManager
        init(_ control: HomeFeedHelper, model: NetworkManager) {
                self.control = control
                self.model = model
            }
    @objc func handleRefreshControl(sender: UIRefreshControl) {
                sender.endRefreshing()
                //MAKE REFRESH CHANGES HERE  e.g. model.refresh()
            }
        }
    

}
/*
struct HomeFeed_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeFeed(model: model)
//            WhatYouMissedSection()
        }
    }
}*/
