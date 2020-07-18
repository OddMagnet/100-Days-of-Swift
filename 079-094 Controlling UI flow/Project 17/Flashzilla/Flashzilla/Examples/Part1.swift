//
//  Part1.swift
//  Flashzilla
//
//  Created by Michael Brünen on 18.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI
import CoreHaptics

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
    @State private var hapticEngine: CHHapticEngine?
    @State private var lastTapped = ""
    
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

            NavigationLink("Making vibrations with UINotificationFeedbackGenerator and Core Haptics", destination:
                VStack {
                    Text("Simple Success Haptics")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .onTapGesture(perform: simpleSuccess)
                    Spacer()
                    Text("Complex Success Haptics")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .onTapGesture(perform: complexSuccess)
                }
                .onAppear(perform: prepareHaptics)
            )

            NavigationLink("Disabling user interactivity with allowsHitTesting()", destination:
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 300, height: 300)
                            .onTapGesture {
                                self.lastTapped = "Rectangle tapped!"
                            }

                        Circle()
                            .fill(Color.red)
                            .frame(width: 300, height: 300)
                            //.contentShape(Rectangle())
                            .onTapGesture {
                                self.lastTapped = "Circle tapped!"
                            }
                            //.allowsHitTesting(false)
                    }
                    Spacer()
                    Text(lastTapped)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    self.lastTapped = "Spacer tapped!"
                }
            )
        }
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            self.hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("There was an error creating the haptics engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
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
