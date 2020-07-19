//
//  Part2.swift
//  Flashzilla
//
//  Created by Michael Brünen on 18.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Part2: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timerCount = ""
    @State private var backgroundMessage = ""
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale: CGFloat = 1
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        Section(header: Text("Part 2")) {
            
            NavigationLink("Triggering events repeatedly using a timer", destination:
                VStack {
                    Button("Stop timer") {
                        self.timer.upstream.connect().cancel()
                    }
                    Text(timerCount)
                        .onReceive(timer) { time in
                            self.timerCount = "\(time)"
                    }
                }
            )

            NavigationLink("How to be notified when your SwiftUI app moves to the background", destination:
                Text(backgroundMessage)
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                        self.backgroundMessage += "Moving to the background\n"
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                        self.backgroundMessage += "Moving back to the foreground\n"
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
                        self.backgroundMessage += "User took a screenshot!\n"
                    }
            )

            NavigationLink("Supporting specific accessibility needs with SwiftUI", destination:
                VStack {
                    HStack {
                        if differentiateWithoutColor {
                            Image(systemName: "checkmark.circle")
                        }

                        Text("Differentiate without color")
                    }
                    .padding()
                    .background(differentiateWithoutColor ? Color.black : Color.green)
                    .foregroundColor(Color.white)
                    .clipShape(Capsule())
                    
                    Text("Reduce motion, tap me")
                        .padding()
                        .scaleEffect(scale)
                        .onTapGesture {
                            self.withOptionalAnimation {
                                    self.scale *= 1.5
                                }
                        }
                        .onLongPressGesture {
                            self.withOptionalAnimation {
                                self.scale = 1
                            }
                        }
                    
                    Text("Reduced Transparency")
                        .padding()
                        .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
                        .foregroundColor(Color.white)
                        .clipShape(Capsule())
                }
            )
        }
    }
    
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

struct Part2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Part2()
            }
            .navigationBarTitle("Examples")
        }
    }
}
