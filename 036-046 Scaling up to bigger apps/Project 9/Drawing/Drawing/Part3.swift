//
//  Day3.swift
//  Drawing
//
//  Created by Michael Brünen on 17.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Part3: View {
    @State private var sizeAmount: CGFloat = 0.0
    @State private var blurAmount: CGFloat = 1.0
    @State private var saturationAmount: CGFloat = 1.0
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount: CGFloat = 1.0
    @State private var hue = 0.6
    
    var body: some View {
        //NavigationView {
        Section(header: Text("Part 3")) {
            
            NavigationLink("Special effects in SwiftUI", destination:
                VStack {
                    ZStack {
                        Circle()
                            .fill(Color(red: 1, green: 0, blue: 0))
                            .frame(width: 160 * sizeAmount)
                            .offset(x: -40, y: -40)
                            .blendMode(.screen)
                        
                        Circle()
                            .fill(Color(red: 0, green: 1, blue: 0))
                            .frame(width: 160 * sizeAmount)
                            .offset(x: 40, y: -40)
                            .blendMode(.screen)
                        
                        Circle()
                            .fill(Color(red: 0, green: 0, blue: 1))
                            .frame(width: 160 * sizeAmount)
                            .offset(x: 0, y: 40)
                            .blendMode(.screen)
                    }
                    .frame(width: 300, height: 250)
                    .background(Color.black)
                    
                    VStack {
                        Text("Circle Size")
                        Slider(value: $sizeAmount)
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        Image("Example")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .saturation(Double(saturationAmount))
                            .blur(radius: (1 - blurAmount) * 20)
                        
                        VStack {
                            Text("Circle blur")
                            Slider(value: $blurAmount)
                        }
                        .padding(.horizontal)
                        
                        VStack {
                            Text("Circle saturation")
                            Slider(value: $saturationAmount)
                        }
                        .padding(.horizontal)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
            
            NavigationLink("Animating simple shapes with animatableData", destination:
                AnimatableTrapezoid()
            )
            
            NavigationLink("Animating complex shapes with AnimatablePair", destination:
                AnimatableCheckerboard()
            )
            
            NavigationLink("Creating a spirograph with SwiftUI", destination:
                VStack(spacing: 0) {
                    Spacer()

                    Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                        .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                        .frame(width: 300, height: 300)

                    Spacer()

                    Group {
                        Text("Inner radius: \(Int(innerRadius))")
                        Slider(value: $innerRadius, in: 10...150, step: 1)
                            .padding([.horizontal, .bottom])

                        Text("Outer radius: \(Int(outerRadius))")
                        Slider(value: $outerRadius, in: 10...150, step: 1)
                            .padding([.horizontal, .bottom])

                        Text("Distance: \(Int(distance))")
                        Slider(value: $distance, in: 1...150, step: 1)
                            .padding([.horizontal, .bottom])

                        Text("Amount: \(amount, specifier: "%.2f")")
                        Slider(value: $amount)
                            .padding([.horizontal, .bottom])

                        Text("Color")
                        Slider(value: $hue)
                            .padding(.horizontal)
                    }
                }
            )
            
        }
        //}
    }
}

struct Day3_Previews: PreviewProvider {
    static var previews: some View {
        Part3()
    }
}
