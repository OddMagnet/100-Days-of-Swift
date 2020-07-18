//
//  Part1.swift
//  Flashzilla
//
//  Created by Michael Brünen on 18.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Part1: View {
    @State private var doubleTapped = false
    @State private var longPressed = false
    @State private var longPressInProgess = false
    @State private var currentScaleAmount: CGFloat = 0
    @State private var finalScaleAmount: CGFloat = 1
    @State private var currentRotationAmount: Angle = .degrees(0)
    @State private var finalRotationAmount: Angle = .degrees(0)
    @State private var isDragable = false
    @State private var dragOffset = CGSize.zero
    
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in self.dragOffset = value.translation }
            .onEnded { _ in
                withAnimation {
                    self.dragOffset = .zero
                    self.isDragable = false
                }
            }
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    self.isDragable = true
                }
            }
        let longPressThenDragGesture = pressGesture.sequenced(before: dragGesture)
        
        return Section(header: Text("Part 1")) {
            
            NavigationLink("How to use gestures in SwiftUI", destination:
                VStack {
                    Text("Double Tap Me")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(doubleTapped ? Color.green : Color.red)
                        .onTapGesture(count: 2){
                            self.doubleTapped.toggle()
                    }
                    Spacer()
                    Text("Long Press Me\(longPressInProgess ? "..." : "")")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(longPressed ? Color.green : Color.red)
                        .onLongPressGesture(minimumDuration: 2, pressing: { inProgess in
                            self.longPressInProgess = inProgess
                        }) {
                            self.longPressed.toggle()
                    }
                    Spacer()
                    Text("Pinch me")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .scaleEffect(finalScaleAmount + currentScaleAmount)
                        .gesture(
                            MagnificationGesture()
                                .onChanged { amount in
                                    self.currentScaleAmount = amount - 1
                                }
                                .onEnded { amount in
                                    self.finalScaleAmount += self.currentScaleAmount
                                    self.currentScaleAmount = 0
                                }
                        )
                    Spacer()
                    Text("Rotate me")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .rotationEffect(finalRotationAmount + currentRotationAmount)
                        .gesture(
                            RotationGesture()
                                .onChanged { angle in
                                    self.currentRotationAmount = angle
                                }
                                .onEnded { angle in
                                    self.finalRotationAmount += self.currentRotationAmount
                                    self.currentRotationAmount = .degrees(0)
                                }
                        )
                    Spacer()
                    Text("Long press, then drag me")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isDragable ? Color.green : Color.red)
                        .offset(dragOffset)
                        .gesture(longPressThenDragGesture)
                    Spacer()
                }
            )

            NavigationLink("Placeholder 2", destination:
                Text("Placeholder 2")
            )

            NavigationLink("Placeholder 3", destination:
                Text("Placeholder 3")
            )
        }
    }
}

struct Part1_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Part1()
            }
            .navigationBarTitle("Examples")
        }
    }
}
