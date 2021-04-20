//
//  Post.swift
//  justice-for-families
//
//  Created by Sydney Chiang on 12/8/20.
//
import Foundation
import SwiftUI
import Combine
import Alamofire



/*

struct AddPostView: View {
    @State private var showModal = false
    
    var body: some View {
        Button(action:{
            self.showModal.toggle()
        }){
            Text("Show modal")

        }.sheet(isPresented: $showModal){
            PopUp()
        }
    }
}*/

struct PopUp: View{
    
    @State var title: String = ""
    @State var postBody: String = ""
    @Environment(\.presentationMode) private var presentationMode
    
    let postURL = URL(string: "http://localhost:3000/posts/create")
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Image("replace this later")
                        .frame(width: 60, height: 60)
                        .background(Color.gray)
                        .cornerRadius(30)
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                    Text("Choose a community")
                        .frame(width: .infinity, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.secondary)
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 24))
                }
                Divider()
                TextField("Title (required)", text: $title)
                    .frame(width: .infinity, height: 82, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                Divider()
                TextField("What's on your mind?", text: $postBody)
                    .font(.custom("Robot-Regular", size: 14))
                    .frame(width: .infinity, height: 160, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    
                Spacer()
            }
            .navigationBarTitle("Text Post")
            .navigationBarTitleDisplayMode(.inline)
            .font(.custom("Roboto-Bold", size: 16))
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark").font(.system(size: 16, weight: .regular))
            }, trailing:
                Button(action: {
                    //username is your email
                    let parameters = ["text" :      postBody,
                                      "username" : UserDefaults.standard.object(forKey: "LoggedInUser")!,
                                      "tags" : ["tag#1"],
                                      "numComments" : 0,
                                      "title" : title,
                                      "anonymous" : false,
                                      "numLikes" : 0] as [String : Any]
                    if (title.count > 0) {
                        Network.createNewPost(parameters: parameters)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }){
                    Text("POST")
                }
            
            
            )
        }
    }
}

struct Post_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PopUp()
        }
    }
}
