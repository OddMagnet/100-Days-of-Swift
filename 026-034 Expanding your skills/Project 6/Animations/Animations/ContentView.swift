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
    @State private var animationAmount1: CGFloat = 1
    @State private var animationAmount2: CGFloat = 1
    @State private var animationAmount3: CGFloat = 1
    @State private var animationAmount4: CGFloat = 1
    
    var body: some View {
        Form {
            Section(header: Text("Implicit animation example")) {
                Button("Tap Me") {
                    self.animationAmount1 += 0.25
                }
                .padding(50)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(animationAmount1)
                .blur(radius: (animationAmount1 - 1) * 2)
                .animation(.default)
            }
            
            Section(header: Text("Customized implicit animation example")) {
                Button("See me") {
                }
                .padding(50)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.red)
                        .scaleEffect(animationAmount2)
                        .opacity(Double(2 - animationAmount2))
                        .animation(
                            Animation.easeOut(duration: 1)
                                .repeatForever(autoreverses: false)
                    )
                )
                    .onAppear {
                        self.animationAmount2 = 1.2
                }
                .padding(10)
            }
            
            Section(header: Text("Animating bindings example")) {
                Stepper("Scale amount", value: $animationAmount3.animation(), in: 1...1.5, step: 0.1)
                Button("Steps") {
                    //self.animationAmount3 += 0.2
                }
                .padding(40)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(animationAmount3)
                .padding(25)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
