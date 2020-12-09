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
    
    @State var txt = ""
    @State var height : CGFloat = 20
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    //@StateObject var postData = PostViewModel()
    var body: some View {
        ScrollView{
            VStack{
                PostRow()
                CommentRow()
            }
            .padding()
            .background(Constants.backgroundColor)
        }
        
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

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
