//
//  Examples.swift
//  Drawing
//
//  Created by Michael Brünen on 15.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

// Paths vs Shapes
struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    // Version 1
    //    func path(in rect: CGRect) -> Path {
    //        var path = Path()
    //        path.addArc(center: CGPoint(x: rect.midX, y: rect.maxY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
    //
    //        return path
    //    }
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
}


// StrokeBorder support with InsettableShape
struct InsettableArc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self  // needed since self is not mutable, so we return a changed copy
        arc.insetAmount += amount
        return arc
    }
}

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


struct Examples: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    @State private var colorCycle = 0.0
    @State private var colorCycleMetal = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Spacer()
                    
                    NavigationLink(destination: GeometryReader { geo in
                        Path { path in
                            let centerX = geo.size.width / 2
                            let centerY = geo.size.height / 2
                            path.move(to: CGPoint(x: centerX, y: centerY - 60))
                            path.addLine(to: CGPoint(x: centerX - 60, y: centerY + 60))
                            path.addLine(to: CGPoint(x: centerX + 60, y: centerY + 60))
                            path.addLine(to: CGPoint(x: centerX, y: centerY - 60))
                        }
                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    }) {
                        Text("Creating custom paths with SwiftUI")
                    }
                    
                    Spacer()
                    
                    NavigationLink("Paths vs Shapes",
                                   destination: Arc(startAngle: .degrees(-90),
                                                    endAngle: .degrees(180),
                                                    clockwise: true)
                                    .stroke(Color.blue, lineWidth: 40)
                    )
                    
                    Spacer()
                    
                    NavigationLink("StrokeBorder support with InsettableShape",
                                   destination: InsettableArc(startAngle: .degrees(180),
                                                              endAngle: .degrees(90),
                                                              clockwise: true)
                                    .strokeBorder(Color.red, lineWidth: 40)
                    )
                    
                }
                
                VStack {
                    Spacer()
                    
                    NavigationLink("Transforming shapes",
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
                    
                    Spacer()
                    
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
                    
                    Spacer()
                    
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
                    
                    Spacer()
                }
                
            }
            .navigationBarTitle("Examples")
        }
    }
}

struct Examples_Previews: PreviewProvider {
    static var previews: some View {
        Examples()
    }
}
