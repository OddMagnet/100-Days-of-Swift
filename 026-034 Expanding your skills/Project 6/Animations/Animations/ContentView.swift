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
    @State private var enabled = false
    @State private var animationAmount1: CGFloat = 1
    @State private var animationAmount2: CGFloat = 1
    @State private var animationAmount3: Double = 0.0
    @State private var dragAmount = CGSize.zero
    
    let letters = Array("Hello SwiftUI")
    
    var body: some View {
        Form {
            Section(header: Text("Implicit animation examples")) {
                HStack {
                    Button("Tap Me") {
                        self.enabled.toggle()   // implicit animation
                    }
                    .frame(width: 100, height: 100)
                    .background(enabled ? Color.blue : Color.red)
                    .animation(.default)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
                    .animation(.interpolatingSpring(stiffness: 10, damping: 1))
                    
                    Spacer()
                    
                    Button("Custom") {
                    }
                    .padding(40)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.red)
                            .scaleEffect(animationAmount1)
                            .opacity(Double(2 - animationAmount1))
                            .animation( // customized part
                                Animation.easeOut(duration: 1)
                                    .repeatForever(autoreverses: true)
                        )
                    )
                        .onAppear {
                            self.animationAmount1 = 1.2
                    }
                    .padding(10)
                }
            }
            
            Section(header: Text("Animating bindings example")) {
                Stepper("Scale amount", value: $animationAmount2.animation(), in: 1...3, step: 0.3)
                Button("Steps") {
                    //self.animationAmount3 += 0.2
                }
                .padding(40)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Rectangle())
                .scaleEffect(x: animationAmount2, y: 1, anchor: .leading)
            }
            
            Section(header: Text("Explicit animation example")) {
                Button("Tap Me") {
                    withAnimation { // explicit animation
                        self.animationAmount3 += 360
                    }
                }
                .padding(40)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .rotation3DEffect(.degrees(animationAmount3), axis: (x: 1, y: 1, z: 1))
            }
            
            Section(header: Text("Animating gestures (drag me)")) {
                HStack(spacing: 0) {
                    ForEach(0 ..< letters.count) { num in
                        Text(String(self.letters[num]))
                            .padding(5)
                            .font(.title)
                            .background(self.enabled ? Color.blue : Color.red)
                            .offset(self.dragAmount)
                            .animation(Animation.default.delay(Double(num) / 20))
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { self.dragAmount = $0.translation }
                        .onEnded { _ in
                            self.dragAmount = .zero
                            self.enabled.toggle()
                    }
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
