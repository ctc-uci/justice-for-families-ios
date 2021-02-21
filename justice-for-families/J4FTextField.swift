//
//  J4FTextField.swift
//  justice-for-families
//
//  Created by Jules Labador on 1/24/21.
//

import SwiftUI

struct J4FTextField: View {
    
    @State var input = ""
    private var fieldWidth: CGFloat? = 350
    private var fieldHeight: CGFloat? = 60
    
    var body: some View {
        TextField("Name", text: $input)
            .frame(width: self.fieldWidth, height: self.fieldHeight, alignment: .leading)
            .background(Color(.sRGB, red: 196/255.0, green: 215/255.0, blue: 235/255.0, opacity: 0.50))
            .cornerRadius(20)
            .font(Font.custom("AvenirNext-Regular", size: 16))
            .foregroundColor(Color(.sRGB, red: 25/255.0, green: 118/255.0, blue: 157/255.0, opacity: 1.0))
    }
}

struct J4FTextField_Previews: PreviewProvider {
    static var previews: some View {
        J4FTextField()
    }
}
