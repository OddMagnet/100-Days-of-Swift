//
//  Part2.swift
//  Instafilter
//
//  Created by Michael Brünen on 01.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct Part2: View {
    @State private var image: Image?
    
    var body: some View {
        Section(header: Text("Part 2")) {
            
            NavigationLink("Integrating Core Image with SwiftUI", destination:
                VStack {
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onAppear(perform: loadImage)
            )
            
            NavigationLink("Wrapping a UIViewController in a SwiftUI view", destination:
                Text("1")
            )

        }
    }
    
    func loadImage() {
        // load image and put it into a CIImage
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)
        
        // create context and filter
        let context = CIContext()
        let currentFiler = CIFilter.sepiaTone()
        
        // configure filter
        currentFiler.inputImage = beginImage
        currentFiler.intensity = 1
        
        // get the output image
        guard let outputImage = currentFiler.outputImage else { return }
        // convert the CIImage to CGImage
        if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
            // and again convert it, CGImage -> UIImage
            let uiImg = UIImage(cgImage: cgImg)
            
            //finally convert it to SwiftUI's image view
            image = Image(uiImage: uiImg)
        }
    }
}

struct Part2_Previews: PreviewProvider {
    static var previews: some View {
        Part2()
    }
}
