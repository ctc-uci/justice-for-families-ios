//
//  ImagePicker.swift
//  justice-for-families
//
//  Created by Sydney Chiang on 5/4/21.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:Any]) {

            guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
            parent.imageUrl = (fileUrl)
            
            
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    parent.image = uiImage
                  }
            
            parent.presentationMode.wrappedValue.dismiss()

        }
       
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    @Binding var imageUrl: URL?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
}
