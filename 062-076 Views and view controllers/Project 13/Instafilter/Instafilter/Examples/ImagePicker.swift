//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Michael Brünen on 01.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    // After adding the protocol the first fix Xcode suggests adds the following:
    // typealias UIViewControllerType = 'Type'
    // adding the type this struct should represent is enough information for Xcode
    // so that the next fix can add the needed functions to conform to the protocol
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // not needed for this example
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker()
    }
}
