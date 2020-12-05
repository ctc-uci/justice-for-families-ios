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
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    //@StateObject var postData = PostViewModel()
    var body: some View {
        ScrollView{
            VStack{
                PostRow()
                //put comments here
            }
            .padding()
            .background(Color(red: 211/255, green: 211/255, blue: 211/255))
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
