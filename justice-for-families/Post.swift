//
//  Post.swift
//  justice-for-families
//
//  Created by Sydney Chiang on 12/8/20.
//

import Foundation
import SwiftUI


//@State public var showModal = false
struct Post: View {
    @State private var showModal = false
    
    var body: some View {
//        PopUp()
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
                    .foregroundColor(.secondary)
                    .frame(width: .infinity, height: 160, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                Spacer()
            }
            .navigationBarTitle("Text Post")
            .navigationBarTitleDisplayMode(.inline)
            .font(.custom("Roboto-Bold", size: 16))
        }
        .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.system(size: 16, weight: .regular))
        }), trailing: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("POST")
        }))
    }
}


struct Post_Previews: PreviewProvider {
    static var previews: some View {
        Post()
    }
}
