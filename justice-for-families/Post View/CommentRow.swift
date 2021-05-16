//
//  CommentRow.swift
//  justice-for-families
//
//  Created by Cyre Jorin To on 12/9/20.
//

import SwiftUI

struct CommentRow: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
                
            HStack(spacing: 10) {
                Text("@username")
                    .font(.headline)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                Text("20m ago")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
    
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                .font(.custom("San Francisco", size: 12))
           
            VStack(alignment: .trailing, spacing: 10) {
                HStack(spacing:10) {
                    Spacer()
                    Button(action: {}){
                        Text("•••")
                            .font(.custom("Roboto", size: 12))
                            .foregroundColor(.gray)
                    }
                    Button(action: {}){
                        Text("REPLY")
                        .font(.custom("Roboto", size: 12))
                        .foregroundColor(.gray)
                    }
                    Button(action: {}){
                        Text("LIKE")
                        .font(.custom("Roboto", size: 12))
                        .foregroundColor(.gray)
                    }
                }
            }

        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}


