//
//  TagCell.swift
//  justice-for-families
//
//  Created by Jules Labador on 3/6/21.
//

import SwiftUI

struct TagCell: View {
    
    let tag: String
    
    var body: some View {
        
        Text(tag)
            .frame(width: nil, height: 30, alignment: .center)
            .padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
            .background(Color(.sRGB, red: 196/255.0, green: 215/255.0, blue: 235/255.0, opacity: 0.3))
            .cornerRadius(40)
            .foregroundColor(J4FColors.darkBlue)
        
    }
    
}
