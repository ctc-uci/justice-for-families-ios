//
//  ActivityCell.swift
//  justice-for-families
//
//  Created by Jules Labador on 4/28/21.
//

import SwiftUI

struct ActivityCell: View {
    
    let activity: Activity
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white)
            VStack {
                Text("Hello")
                    .font(J4FFonts.postText)
                    .multilineTextAlignment(.leading)
            }
            .padding(20)
        }
    }
}

struct ActivityCell_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCell(activity: Activity())
    }
}
