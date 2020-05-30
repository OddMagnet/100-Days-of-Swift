//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Michael Brünen on 30.05.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    @State private var buttonPressed = false
    
    // view as property example
    let propertyView = Text("I'm a property!")
    
    var body: some View {
        VStack(spacing: 20) {
            
            VStack {
                // Example of why modifier order matters
                Text("Background -> Frame")
                    .background(Color.red)
                    .frame(width: 200, height: 30)
                Text("Frame -> Background")
                    .frame(width: 200, height: 30)
                    .background(Color.green)
            }
            
            VStack {
                // Example of conditional modifiers
                Button("Conditional modifier example") {
                    self.buttonPressed.toggle()
                }
                .foregroundColor(.black)
                .padding()
                .background(buttonPressed ? Color.green : Color.red)
            }
            
            VStack {
                // Environment modifier example
                Text("Environment")
                Text("Modifier")
                    .background(Color.yellow)
                Text("Example")
            }
            .padding()
            .background(Color.blue)

            VStack {
                // view as property example
                propertyView
            }
            
            VStack {
                // view composition example
                CapsuleText(text: "View composition example")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
