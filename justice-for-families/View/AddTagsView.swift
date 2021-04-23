//
//  AddTagsView.swift
//  justice-for-families
//
//  Created by Rebecca Leung on 4/20/21.
//

import SwiftUI

struct TagToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            configuration.label
        }
        .frame(alignment: .center)
        .padding(EdgeInsets(top: 6, leading: 9, bottom: 6, trailing: 9))
        .foregroundColor(configuration.isOn ? .white : Constants.secondaryFontColor)
        .background(RoundedRectangle(cornerRadius: 40.0)
                        .fill(configuration.isOn ? Constants.secondaryFontColor : .white))
        .overlay(RoundedRectangle(cornerRadius: 40.0)
                    .stroke(Constants.secondaryFontColor, lineWidth: 0.5))
    }
}

struct AddTagsView: View {
    @Binding var tags: Array<String>
    @State var searchText: String = ""
    
    @State var selectedTags : Dictionary<String, Bool> =  ["resources" : false,
                                                           "j4f" : false,
                                                           "queens" : false,
                                                           "community" : false,
                                                           "rules" : false,
                                                           "new facilities" : false]
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                #if DEBUG
                Divider().padding([.leading, .trailing], 24)
                SearchBar(text: $searchText)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 7)
                #endif
                Divider().padding([.leading, .trailing], 24)
                VStack(alignment: .leading, spacing: 11) {
                    Text("popular")
                        .foregroundColor(Constants.primaryFontColor)
                        .font(.custom("Poppins-Medium", size: 15))
                        .padding(EdgeInsets(top: 11, leading: 24, bottom: 15, trailing: 0))
                    let tagsList = selectedTags.keys.sorted()
                    HStack (spacing: 10) {
                        ForEach(tagsList[0...2], id: \.self) { tag in
                            Toggle("#\(tag.description)", isOn: self.binding(for: tag))
                                .toggleStyle(TagToggleStyle())
                        }
                    }.padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 12))
                    HStack (spacing: 10) {
                        ForEach(tagsList[3...5], id: \.self) { tag in
                            Toggle("#\(tag.description)", isOn: self.binding(for: tag))
                                .toggleStyle(TagToggleStyle())
                        }
                    }.padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 12))
                }
                Divider().padding([.top, .leading, .trailing], 24)
                Spacer()
            }
            .navigationBarTitle("Add tags")
            .navigationBarTitleDisplayMode(.inline)
            .font(.custom("Poppins-Medium", size: 15))
            .navigationBarItems(
                leading: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                Image(systemName: "xmark").font(.system(size: 16, weight: .regular))
            })
        }.onAppear(perform: updateSelectedTags)
         .onDisappear(perform: saveTags)
    }
    
    private func binding(for key: String) -> Binding<Bool> {
        return .init(
            get: { self.selectedTags[key, default: false] },
            set: { self.selectedTags[key] = $0 }
        )
    }
    
    private func updateSelectedTags() {
        for t in self.tags {
            self.selectedTags[t] = true
        }
        print(selectedTags)
    }
    
    private func saveTags() {
        tags.removeAll()
        for (tag, isSelected) in selectedTags {
            if isSelected { tags.append(tag) }
        }
        tags = Array(Set(tags)) // get unique values
    }
}

struct AddTagsView_Previews: PreviewProvider {
    static var previews: some View {
        AddTagsView(tags: .constant(["community"]))
    }
}
