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
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some aView{
        NavigationView {
            Form{
                Section{
                    Text("hello world popup")
                }
            }
            
            .navigationBarItems(leading:          Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                    Image(systemName: "xmark").font(.system(size: 16, weight: .regular))
            }, trailing:
                    Button(action: {
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
        Post()
    }
}
