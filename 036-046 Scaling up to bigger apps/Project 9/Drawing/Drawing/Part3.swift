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
                                
                NavigationLink("2", destination:
                    Text("2")
                )
                                
                NavigationLink("3", destination:
                    Text("3")
                )
                                
                NavigationLink("4", destination:
                    Text("4")
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
