//
//  CommentButton.swift
//  justice-for-families
//
//  Created by Alvin Chen on 1/13/21.
//

import SwiftUI

struct CommentButton: View {
    @State private var commentText = ""
    init() {
            UITextView.appearance().backgroundColor = .clear
        }
    private var fieldWidth: CGFloat? = 300
    private var fieldHeight: CGFloat? = 60
    var body: some View {
        VStack{
            TextEditor(text: self.$commentText)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).fill(Color.gray.opacity(0.2)))
                .frame(width: fieldWidth, height: fieldHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

struct CommentButton_Previews: PreviewProvider {
    static var previews: some View {
        CommentButton()
    }
}
