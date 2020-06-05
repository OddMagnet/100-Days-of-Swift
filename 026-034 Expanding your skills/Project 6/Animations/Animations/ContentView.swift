//
//  ContentView.swift
//  Animations
//
//  Created by Michael Brünen on 05.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // state
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        VStack {
            // Implicit animation example
            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(50 + animationAmount*10)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            //.scaleEffect(animationAmount)
            .blur(radius: (animationAmount - 1) * 3)
            .animation(.default)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
