//
//  SearchBar.swift
//  justice-for-families
//
//  Created by Rebecca Leung on 4/21/21.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var selectedTags : Dictionary<String, Bool>
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            TextField("", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(red: 232/255, green: 237/255, blue: 242/255))
                .cornerRadius(20)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 7)
                .onTapGesture {
                    self.isEditing = true
                }
            
            Button(action: {
                self.isEditing = false
                self.text = ""
            }) {
                Button(action: {
                    if selectedTags.count < 2 {
                        self.selectedTags[text] = true
//                        addedTags.append(text)
                        text.removeAll()
                    }
                }, label: {
                    Text("Add Tag")
                        .font(.custom("Poppins-Normal", size: 12))
                })
            }
            .padding(.trailing, 10)
            .foregroundColor(Constants.primaryFontColor)
    }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), selectedTags: .constant([:]))
    }
}
