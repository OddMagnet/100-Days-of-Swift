//
//  ContentView.swift
//  Drawing
//
//  Created by Michael Brünen on 15.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

// Wrap up - Challenge 1 - create an arrow shape
struct Arrow: Shape {
    // Wrap up - Challenge 2 - Create an Arrow shape with animatable line thickness
    var animatableData: CGFloat {
        get {
            lineThickness
        }
        set {
            self.lineThickness = newValue
        }
    }
    var lineThickness: CGFloat = 75.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
    
        // Arrow head
        path.addLines([
            CGPoint(x: rect.midX, y: 0),
            CGPoint(x: 0, y: rect.midY - 100),
            CGPoint(x: rect.maxX, y: rect.midY - 100)
        ])
        
        // Arrow body
        path.addLines([
            CGPoint(x: rect.midX - lineThickness, y: rect.midY - 100),
            CGPoint(x: rect.midX - lineThickness, y: rect.maxY),
            CGPoint(x: rect.midX + lineThickness, y: rect.maxY),
            CGPoint(x: rect.midX + lineThickness, y: rect.midY - 100)
        ])
        
        return path
    }
}

// Wrap up - Challenge 2 - Create an Arrow shape with animatable line thickness
struct AnimatableArrow: View {
    @State private var thickness: CGFloat = 75.0
    
    var body: some View {
        Arrow(lineThickness: thickness)
            .fill(Color.blue)
            .onTapGesture {
                withAnimation {
                    self.thickness += 10
                }
        }
    }
}

// Wrap up - Challenge 3 - Create a ColorCyclingRectangle with control of gradient position
struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        return ZStack {
            ForEach(0 ..< steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    self.color(for: value, brightness: 1),
                                    self.color(for: value, brightness: 0.5)
                                ]
                            ),
                            startPoint: .top, endPoint: .bottom
                        ),
                        lineWidth: 2
                )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }

}

struct ContentView: View {
    @State private var colorCycle = 0.0
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Examples")) {
                    NavigationLink("Learning examples", destination: Examples())
                }
                Section(header: Text("Challenge 1")) {
                    NavigationLink("Create an Arrow shape", destination:
                        VStack{
                            Arrow()
                                .fill(Color.blue)
                        }
                    )
                }
                Section(header: Text("Challenge 2")) {
                    NavigationLink("Create an Arrow shape with animatable line thickness", destination:
                        AnimatableArrow()
                    )
                }
                Section(header: Text("Challenge 3")) {
                    NavigationLink("Create a ColorCyclingRectangle with control of gradient position", destination:
                        VStack {
                            ColorCyclingRectangle(amount: self.colorCycle)
                                .frame(width: 300, height: 300)
                            
                            Text("Amount")
                            Slider(value: $colorCycle)
                                .padding()

                        }
                    )
                }
            }
            .navigationBarTitle("Drawing")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
