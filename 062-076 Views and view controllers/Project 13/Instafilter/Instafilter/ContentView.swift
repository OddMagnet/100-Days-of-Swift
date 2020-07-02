//
//  ContentView.swift
//  Instafilter
//
//  Created by Michael Brünen on 30.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    // MARK: - State
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var currentFiler = CIFilter.sepiaTone()
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    
    // MARK: - Constants
    let context = CIContext()
    
    // MARK: - UI
    var body: some View {
        
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    // display the image if not nil, else text
                    if image != nil {   // if let not possible, only simple conditions
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change filter") {
                        // change filter
                    }
                    Spacer()
                    Button("Save") {
                        // save the image
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        }
    }
    
    // MARK: - Functions
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFiler.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        currentFiler.intensity = Float(filterIntensity)
        
        guard let outputImage = currentFiler.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
