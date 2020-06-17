//
//  Day1.swift
//  Drawing
//
//  Created by Michael Brünen on 17.06.20.
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

struct Part1: View {
    var body: some View {
        //NavigationView {
        Section(header: Text("Part 1")) {
                                                                
                NavigationLink("Creating custom paths with SwiftUI", destination:
                    GeometryReader { geo in
                        Path { path in
                            let centerX = geo.size.width / 2
                            let centerY = geo.size.height / 2
                            path.move(to: CGPoint(x: centerX, y: centerY - 60))
                            path.addLine(to: CGPoint(x: centerX - 60, y: centerY + 60))
                            path.addLine(to: CGPoint(x: centerX + 60, y: centerY + 60))
                            path.addLine(to: CGPoint(x: centerX, y: centerY - 60))
                        }
                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                })
                                
                NavigationLink("Paths vs Shapes",
                               destination: Arc(startAngle: .degrees(-90),
                                                endAngle: .degrees(180),
                                                clockwise: true)
                                .stroke(Color.blue, lineWidth: 40)
                )
                                
                NavigationLink("StrokeBorder support with InsettableShape",
                               destination: InsettableArc(startAngle: .degrees(180),
                                                          endAngle: .degrees(90),
                                                          clockwise: true)
                                .strokeBorder(Color.red, lineWidth: 40)
                )
                                                                                                                
            }
        //}
    }
}

struct Day1_Previews: PreviewProvider {
    static var previews: some View {
        Part1()
    }
}
