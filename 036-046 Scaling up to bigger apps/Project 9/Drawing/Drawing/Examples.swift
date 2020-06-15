//
//  Examples.swift
//  Drawing
//
//  Created by Michael Brünen on 15.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

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


struct Examples: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Spacer()
                
                Section(header: Text("Creating custom paths with SwiftUI").font(.headline)) {
                    GeometryReader { geo in
                        Path { path in
                            let centerX = geo.size.width / 2
                            let maxY = geo.size.height
                            path.move(to: CGPoint(x: centerX, y: 0))
                            path.addLine(to: CGPoint(x: centerX - 60, y: maxY))
                            path.addLine(to: CGPoint(x: centerX + 60, y: maxY))
                            path.addLine(to: CGPoint(x: centerX, y: 0))
                        }
                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    }
                    .frame(width: 100, height: 100)
                }
                
                Spacer()
                                
                Section(header: Text("Paths vs Shapes").font(.headline)) {
                    Arc(startAngle: .degrees(-90), endAngle: .degrees(180), clockwise: true)
                        .stroke(Color.blue, lineWidth: 10)
                        .frame(width: 100, height: 100)
                }
                
                Spacer()
                                
                Section(header: Text("StrokeBorder support with InsettableShape").font(.headline)) {
                    Spacer(minLength: 5)
                    InsettableArc(startAngle: .degrees(180), endAngle: .degrees(90), clockwise: true)
                    .inset(by: 20)
                    .stroke(Color.red, lineWidth: 120)
                    .frame(width: 200, height: 200)
                }
                
                Spacer()
                
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
