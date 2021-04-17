//
//  PostScreenView.swift
//  justice-for-families
//
//  Created by Joshua Chan on 12/4/20.
//

//https://www.youtube.com/watch?v=yTWPsC6DJFo
//Post ID should get passed to this screen

import SwiftUI

struct PostView: View {
    let post: Post
    @State var txt = ""
    @State var height : CGFloat = 20
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    var body: some View {
            ScrollView{
                VStack{
                    PostRow(post: post)
                   
                }
                .padding()
                .background(Constants.backgroundColor)
            }
            .navigationBarItems(trailing:
                                    HStack(spacing: 120) {
                                        Button(action: {
                                            print("Menu Button Pressed...")
                                        }) {
                                            Text("...")
                                        }
                                        Button(action: {
                                            print("Save button Pressed...")
                                        }) {
                                            Image(systemName: "bookmark")
                                        }
                                    }
                                )
            
            HStack(spacing:8){
                ResizeableTF(txt: self.$txt, height: self.$height)
                    .frame(height:self.height < 150 ? self.height : 150)
                    .padding(.horizontal)
                    .background(Constants.backgroundColor)
                    .cornerRadius(15)
                Button(action: {}){
                    Text("Send")
                    .padding(.top, 6)
                    .padding(.bottom, 6)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(Constants.backgroundColor)
                }
                .cornerRadius(15)
                .padding(.vertical,4)
            }
            .padding(.horizontal)
    }
}
/*
struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
*/
