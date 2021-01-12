//
//  ContentView.swift
//  justice-for-families
//
//  Created by Ethan  Nguyen on 10/24/20.
//

import SwiftUI




struct ContentView: View {
    
    let updates: [Update] = [
        .init(numberOfLikes: 1, numberOfComments: 1),
        .init(numberOfLikes: 10, numberOfComments: 10),
        .init(numberOfLikes: 100, numberOfComments: 100),
        .init(numberOfLikes: 1000, numberOfComments: 1000)
    ]
    
    var body: some View {
        NavigationView {
            List {
                VStack {
                    Text("What you missed")
                    
                }
            }
//            List {
//                VStack(alignment: .leading) {
//                    Text("What you missed...")
//                        .font(.headline)
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 16) {
//                            ForEach(1..<10) { i in
//                                UrgentUpdateView()
//                            }
//                            .frame(width: 200, height: 150)
//                            .background(Color.gray)
//                            .cornerRadius(12)
//                        }.frame(height: 150)
//
//                    }.frame(height: 150)
//                }
//                Spacer()
//                Text("Updates")
//                    .font(.headline)
//
//                ForEach(updates, id: \.id) { u in
//                    UpdateView(u: u)
//                }.frame(minWidth: 0, maxWidth: .infinity)
//                .frame(height: 175)
//                .background(Color.gray)
//                .cornerRadius(12)
//
//            }
            .navigationTitle("Logo")
            .navigationBarItems(trailing:
                Button(action: {}) {
                Image(systemName: "magnifyingglass").font(.system(size: 25, weight: .regular))
            })
        }

    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
