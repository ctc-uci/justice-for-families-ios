//
//  WhatYouMissedCell.swift
//  justice-for-families
//
//  Created by Jules Labador on 3/6/21.
//

import SwiftUI

struct WhatYouMissedCell: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(Color(.sRGB, red: 103/255.0, green: 154/255.0, blue: 151/255.0, opacity: 0.20))
            VStack {
                Text("Update")
            }
            .padding(20)
        }
        .frame(width: 140, height: 80)
        
    }
    
}
