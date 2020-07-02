//
//  Part3.swift
//  Instafilter
//
//  Created by Michael Brünen on 02.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Part3: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        Section(header: Text("Part 2")) {
            
            NavigationLink("Using coordinators to manage SwiftUI view controllers", destination:
                VStack {
                    image?
                        .resizable()
                        .scaledToFit()

                    Button("Select Image") {
                        self.showingImagePicker = true
                    }
                }
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$inputImage)
                }
            )
            
            NavigationLink("How to save images to the user’s photo library", destination:
                Text("1")
            )
            
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct Part3_Previews: PreviewProvider {
    static var previews: some View {
        Part3()
    }
}
