//
//  MeView.swift
//  HotProspects
//
//  Created by Michael Brünen on 17.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "you@yoursite.com"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                    .padding(.horizontal)
                
                TextField("Email Address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                    .padding([.horizontal, .bottom])
                    .autocapitalization(.none)
                
                Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .padding()

                Spacer()
            }
            .navigationBarTitle("Your code")
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        // convert data and pass it to the filter
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        // get output, convert to UIImage and return it
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        // if the above failed, return the xmark.circle symbol
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
