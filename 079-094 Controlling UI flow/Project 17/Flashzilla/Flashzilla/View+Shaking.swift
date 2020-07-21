//
//  View+Shaking.swift
//  Flashzilla
//
//  Created by Michael Brünen on 21.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

// Wrap up - Challenge 1 - Shake the text on timer ending

struct ShakeEffect: GeometryEffect {
    var position: CGFloat
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
    
    init(shakes: Int) {
        position = CGFloat(shakes)
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(
            CGAffineTransform(translationX: -40 * sin(position * 2 * .pi), y: 0)    // only shake on X axis
        )
    }
}

extension View {
    func shaking(shakes: Int) -> some View {
        self.modifier(ShakeEffect(shakes: shakes))
    }
}
