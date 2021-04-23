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
            self.posts = posts
            posts.forEach({
                print($0)
            })
        }
        self.posts.reverse()
    }
    
    
    
}

struct HomeFeed: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    private let posts: [Post] = []
        
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
        NavigationView {
            List {
                
                Section(header: SectionHeader(title: "Tags you follow")){
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack {
                            ForEach(1..<100) { i in
                                TagCell(tag: "Resources")
                                    .background(J4FColors.background)
                            }
                        }.background(J4FColors.background)
                    })
                    .listRowInsets(EdgeInsets())
                    .background(J4FColors.background)
                }.textCase(.none)
                
                Section(header: SectionHeader(title: "What you missed...")){
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack {
                            ForEach(1..<100) { i in
                                WhatYouMissedCell()
                            }
                        }
                    })
                    .listRowInsets(EdgeInsets())
                    .background(J4FColors.background)
                }.textCase(.none)
                
                Section(header: SectionHeader(title: "Feed")) {
                    ForEach(networkManager.posts) { p in
                        FeedCell(post: p)
                            .listRowBackground(J4FColors.background)
                    }
                }.textCase(.none)
                .listStyle(SidebarListStyle())
            }
            .navigationTitle("J4F")
            //.navigationBarBackButtonHidden(true)
            //.navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
  
    }
}
    

struct SectionHeader: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 0))
            .textCase(.none)
            .font(J4FFonts.sectionTitle)
            .frame(width: UIScreen.main.bounds.width, height: 60, alignment: .leading)
            .background(J4FColors.background)
            .foregroundColor(J4FColors.darkBlue)
    }
}

//struct HomeFeedHelper: UIViewRepresentable {
//    var width : CGFloat
//    var height : CGFloat
//
//    var networkManager = NetworkManager()
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self, model: networkManager)
//    }
//
//    func makeUIView(context: Context) -> UIScrollView {
//        let control = UIScrollView()
//        control.refreshControl = UIRefreshControl()
//        control.refreshControl?.addTarget(context.coordinator, action:
//            #selector(Coordinator.handleRefreshControl),
//                                          for: .valueChanged)
//
//        let childView = UIHostingController(rootView: UIFeed(networkManager: networkManager))
//            childView.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
//
//            control.addSubview(childView.view)
//            return control
//        }
//
//    func updateUIView(_ uiView: UIScrollView, context: Context) {}
//
//    class Coordinator: NSObject {
//            var control: HomeFeedHelper
//        var model : NetworkManager
//        init(_ control: HomeFeedHelper, model: NetworkManager) {
//                self.control = control
//                self.model = model
//            }
//    @objc func handleRefreshControl(sender: UIRefreshControl) {
//                sender.endRefreshing()
//                //MAKE REFRESH CHANGES HERE  e.g. model.refresh()
//            }
//        }
//
//
//}
/*
struct HomeFeed_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeFeed()
        }
    }
}*/
