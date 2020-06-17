//
//  Day2.swift
//  Drawing
//
//  Created by Michael Brünen on 17.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

// Transforming shapes using CGAffineTransform and even-odd fills
struct Flower: Shape {
    // How much to move this petal away from the center
    var petalOffset: Double = -20
    
    // How wide to make each petal
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        // Create a new empty path.
        var path = Path()
        
        // Count from 0 up to pi multiplied by 2 (360 degrees in radians), counting in one eighth of pi each time – this will create 16 petals.
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            // Create a rotation transform equal to the current number.
            let rotation = CGAffineTransform(rotationAngle: number)
            
            // Add to that rotation a movement equal to half the width and height of our draw space, so each petal is centered in our shape.
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            // Create a new path for a petal, equal to an ellipse of a specific size.
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
            
            // Apply our transform to that ellipse so it’s moved into position.
            let rotatedPetal = originalPetal.applying(position)
            
            //Add that petal’s path to our main path
            path.addPath(rotatedPetal)
        }
        
        // return the final shape
        return path
    }
}

// Enabling high-performance Metal rendering with drawingGroup()
struct ColorCyclingMetalView: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        return ZStack {
            ForEach(0 ..< steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    //.strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
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

struct ColorCyclingView: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        return ZStack {
            ForEach(0 ..< steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    //.strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
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
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Part2: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    @State private var colorCycle = 0.0
    @State private var colorCycleMetal = false

    var body: some View {
        //NavigationView {
            Section(header: Text("Part 2")) {
                                                                                                
                NavigationLink("Transforming shapes using CGAffineTransform and even-odd fills",
                               destination: VStack {
                                Text("Transforming shapes").font(.headline)
                                Text("using CGAffineTransform and even-odd fills")
                                Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                                    .fill(Color.red, style: FillStyle(eoFill: true))
                                
                                Text("Offset")
                                Slider(value: $petalOffset, in: -40...40)
                                    .padding([.horizontal, .bottom])
                                
                                Text("Width")
                                Slider(value: $petalWidth, in: 0...100)
                                    .padding(.horizontal)
                })
                                
                NavigationLink("Creative borders and fills using ImagePaint", destination:
                    //  Text("Hello Image
                    //      .frame(width: 300, height: 300)
                    //      .border(
                    //          ImagePaint(image: Image("Example"),
                    //                  sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5),
                    //                  scale: 0.1),
                    //          width: 30)
                    Capsule()
                        .strokeBorder(ImagePaint(image: Image("Example"), scale: 0.1), lineWidth: 20)
                        .frame(width: 300, height: 200)
                )
                                
                NavigationLink("Metal rendering with drawingGroup()", destination:
                    VStack {
                        if colorCycleMetal {
                            ColorCyclingMetalView(amount: self.colorCycle)
                                .frame(width: 300, height: 300)
                        } else {
                            ColorCyclingView(amount: self.colorCycle)
                                .frame(width: 300, height: 300)
                        }
                        
                        Text("Amount")
                        Slider(value: $colorCycle)
                            .padding()
                        
                        Toggle(isOn: $colorCycleMetal, label: {
                            Text("Use Metal?")
                        })
                            .padding()
                    }
                    .padding(.horizontal, 20)
                )
                                                                
            }
        //}
    }
}

struct Day2_Previews: PreviewProvider {
    static var previews: some View {
        Part2()
    }
}
