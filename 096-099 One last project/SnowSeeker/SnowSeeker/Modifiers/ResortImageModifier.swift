//
//  ResortImageModifier.swift
//  SnowSeeker
//
//  Created by Michael Brünen on 26.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

extension Image {
    
    func resortImage(width: CGFloat, height: CGFloat, cornerRadius: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .clipShape(
                RoundedRectangle(cornerRadius: cornerRadius)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}

struct ResortImageModifier: View {
    var body: some View {
        Image(Resort.example.country)
            .resortImage(width: 400, height: 250, cornerRadius: 50)
    }
}

struct ResortImageModifier_Previews: PreviewProvider {
    static var previews: some View {
        ResortImageModifier()
    }
}
