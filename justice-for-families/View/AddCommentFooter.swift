//
//  AddCommentFooter.swift
//  justice-for-families
//
//  Created by Cyre Jorin To on 12/9/20.
//

import SwiftUI

struct ResizeableTF : UIViewRepresentable{
    
    @Binding var txt : String
    @Binding var height : CGFloat
    
    func makeCoordinator() -> Coordinator {
        return ResizeableTF.Coordinator(parent1: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isEditable = true
        view.isScrollEnabled = true
        view.text = "Add Comment"
        view.font = .systemFont(ofSize: 12)
        view.textColor = .white
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            self.height = uiView.contentSize.height
        }
    }
    
    class Coordinator : NSObject,UITextViewDelegate{
        var parent : ResizeableTF
        init(parent1 : ResizeableTF){
            parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if self.parent.txt == ""{
                textView.text = ""
                textView.textColor = .white
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.txt = textView.text
            }
        }
    }
}
