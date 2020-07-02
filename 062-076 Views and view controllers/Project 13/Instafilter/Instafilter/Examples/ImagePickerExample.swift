//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Michael Brünen on 01.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ImagePickerExample: UIViewControllerRepresentable {
    // After adding the protocol the first fix Xcode suggests adds the following:
    // typealias UIViewControllerType = 'Type'
    // adding the type this struct should represent is enough information for Xcode
    // so that the next fix can add the needed functions to conform to the protocol
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        // Part 2 Code
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator // Part 3
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // not needed for this example
    }
    
    
    // Part 3 Code
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerExample
        
        init(_ parent: ImagePickerExample) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}

struct ImagePickerExample_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerExample(image: .constant(UIImage()))
    }
}
