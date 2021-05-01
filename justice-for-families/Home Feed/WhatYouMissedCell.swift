//
//  WhatYouMissedCell.swift
//  justice-for-families
//
//  Created by Joshua Chan on 4/28/21.
//

import Foundation

import SwiftUI

struct WhatYouMissedCell: View {
    //let post: Any
    

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(Color(.sRGB, red: 196/255.0, green: 215/255.0, blue: 235/255.0, opacity: 0.3))
            VStack(alignment: .center){
                Button(action: {

                    //Network.getWhatYouMissed()
                }) {
                    Text("@person commented on your post!").fixedSize(horizontal: false, vertical: true).font(.system(size: 12))
                }
                
                Spacer()
                Text("x hours ago").font(.system(size: 12)).frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(20)
            
            //NavigationLink(destination: PostView(post: post)) { EmptyView() }
            //.opacity(0.0)
        }
        .frame(width: 140, height: 80)
    }
}
