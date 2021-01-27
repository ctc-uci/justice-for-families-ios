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



struct Post: View {
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
}

struct PopUp: View{
    @State var title: String = ""
    @State var postBody: String = "What's on your mind?"
    var placeholderString: String = "What's on your mind?"
    @Environment(\.presentationMode) private var presentationMode
    
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
                TextEditor(text: $postBody)
                    .font(.custom("Robot-Regular", size: 14))
                    .foregroundColor(self.postBody == placeholderString ? .secondary : .primary)
                    .frame(width: .infinity, height: 160, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                     .onTapGesture {
                         if self.postBody == placeholderString {
                             self.postBody = ""
                         }
                     }
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
                        print("hi")
                        let parameters = ["text" : "text",
                                          "username" : "microsoft",
                                          "tags" : ["hello"],
                                          "numComments" : 5,
                                          "title" : "newPost",
                                          "anonymous" : false,
                                          "numLikes" : 5] as [String : Any]
                        AF.request(URL.init(string: "localhost:3000/posts/create")!, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
                                print(response.result)

                                switch response.result {

                                case .success(_):
                                    if let json = response.value
                                    {
                                       // successHandler((json as! [String:AnyObject]))
                                        print(json)
                                    }
                                    break
                                case .failure(let error):
                                   // failureHandler([error as Error])
                                    print(error)
                                    break
                                }
                            }
                        self.presentationMode.wrappedValue.dismiss()
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
            Post()
//            WhatYouMissedSection()
        }
    }
}
