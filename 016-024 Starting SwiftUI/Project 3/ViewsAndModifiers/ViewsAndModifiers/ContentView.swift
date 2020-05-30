//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Michael Brünen on 30.05.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

// custom view example
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

// custom modifier example
struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
        }
    }
}
extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

// custom container example
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content  // must be a closure that accepts 2 integers and return some content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in  // more about \.self in project 5
                HStack {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}

// Wrap up - Challenge 1
struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            .shadow(radius: 2)
    }
}
extension View {
    func prominentTitle() -> some View {
        self.modifier(ProminentTitle())
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
                CapsuleText(text: "Custom view example")
            }
            
            VStack {
                // custom view modifier example
                Color.blue
                    .frame(width: 200, height: 100)
                    .watermarked(with: "Custom modifier example")
            }
            
            VStack {
                // custom container example
                GridStack(rows: 3, columns: 3) { row, col in    // closure must accept 2 ints and return some content
                    HStack {
                        Image(systemName: "\(row * 4 + col).circle")
                        Text("R\(row) C\(col)")
                    }
                    .frame(width: 100, height: 30)
                    .border(Color.black)
                }
            }
            
            VStack {
                // Wrap up - Challenge 1
                Text("Wrap up - Challenge 1")
                .prominentTitle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
