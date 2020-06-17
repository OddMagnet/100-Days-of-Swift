//
//  Part3Spirograph.swift
//  Drawing
//
//  Created by Michael Brünen on 17.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Spirograph: Shape {
    // circle radius
    let innerRadius: Int
    let outerRadius: Int
    // distance from center of outer circle
    let distance: Int
    // amount of patterns to draw
    let amount: CGFloat
    
    func greatestCommonDivisor(of a: Int, and b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
    
    func path(in rect: CGRect) -> Path {
        // prepare variables, convert to CGFloat where needed
        let divisor = greatestCommonDivisor(of: innerRadius, and: outerRadius)
        let outerRadius = CGFloat(self.outerRadius)
        let innerRadius = CGFloat(self.innerRadius)
        let distance = CGFloat(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * CGFloat.pi * outerRadius / CGFloat(divisor)) * amount
        
        // create empty path
        var path = Path()
        
        // "theta" are the points in a spirograph that are being connected
        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            // formula taken from
            // https://en.wikipedia.org/wiki/Hypotrochoid
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)

            x += rect.width / 2
            y += rect.height / 2

            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        // return final path
        return path
    }
}
