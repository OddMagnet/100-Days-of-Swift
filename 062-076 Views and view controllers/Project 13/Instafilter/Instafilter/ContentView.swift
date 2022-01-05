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
    @State private var processedImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var filterIntensity = 0.5        // Wrap up - Challenge 3
    @State private var filterRadius = 0.5           // Wrap up - Challenge 3
    @State private var filterScale = 0.5            // Wrap up - Challenge 3
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    @State private var showingNoImageError = false  // Wrap up - Challenge 1
    
    // MARK: - Constants
    let context = CIContext()
    
    // MARK: - Computed Properties
    // Wrap up - Challenge 2
    var filterName: String {
        let startIndex = currentFilter.name.startIndex
        let removeIndex = currentFilter.name.index(startIndex, offsetBy: 2)
        return String(currentFilter.name[removeIndex...])
    }
    
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
        // Wrap up - Challenge 3
        let radius = Binding<Double>(
            get: {
                self.filterRadius
            },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )
        // Wrap up - Challenge 3
        let scale = Binding<Double>(
            get: {
                self.filterScale
            },
            set: {
                self.filterScale = $0
                self.applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(image == nil ? Color.secondary : Color(hue: 0, saturation: 0, brightness: 0, opacity: 0))
                    
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
                
                // Wrap up - Challenge 3
                Group {
                    if (currentFilter.inputKeys.contains(kCIInputIntensityKey)) {
                        HStack {
                            Text("Intensity")
                            Slider(value: intensity)
                        }
                    }

                    if (currentFilter.inputKeys.contains(kCIInputRadiusKey)) {
                        HStack {
                            Text("Radius   ")
                            Slider(value: radius)
                        }
                    }
                    if (currentFilter.inputKeys.contains(kCIInputScaleKey)) {
                        HStack {
                            Text("Scale    ")
                            Slider(value: scale)
                        }
                    }
                }
                .padding(.vertical)
                
                HStack {
                    Button(filterName) {    // Wrap up - Challenge 2
                        self.showingFilterSheet = true
                    }

                    Spacer()

                    Button("Save", action: save)
                        .disabled(inputImage == nil)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Group {
                    Button("Bloom") { setFilter(CIFilter.bloom()) }
                    Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                    Button("Edges") { setFilter(CIFilter.edges()) }
                    Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                    Button("Noir") { setFilter(CIFilter.photoEffectNoir()) }
                    Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                    Button("Pointillize") { setFilter(CIFilter.pointillize()) }
                    Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                    Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                    Button("Vignette") { setFilter(CIFilter.vignette()) }
                }

                Group {
                    Button("Cancel", role: .cancel) { }
                }
            }
            // Wrap up - Challenge 1
            .alert(isPresented: $showingNoImageError) {
                Alert(title: Text("No image"),
                      message: Text("Please edit an image before saving"),
                      dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    // MARK: - Functions
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 100, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }

    func save() {
        guard let processedImage = self.processedImage else {
            // Wrap up - Challenge 1
            self.showingNoImageError = true
            return
        }

        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Success!")
        }

        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
