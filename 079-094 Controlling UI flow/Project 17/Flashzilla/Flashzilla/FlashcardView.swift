//
//  FlashcardView.swift
//  Flashzilla
//
//  Created by Michael Brünen on 20.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct FlashcardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var hapticFeedback = UINotificationFeedbackGenerator()
    let card: Flashcard
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    // Accessibility for color blind people
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                            .opacity(1 - Double(abs(offset.width / 50)))
                )
                .shadow(radius: 10)
                .background(
                    // Accessibility for color blind people
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(offset.width > 0 ? Color.green : Color.red)
                )
            
            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5))) // rotate slowly, 1/5 of the actual movement
        .offset(x: offset.width * 4, y: 0)                  // move fast horiziontally, 2x the movement
        .opacity(opacity(for: offset, after: 100))          // opacity goes down after 50 units
        .accessibility(addTraits: .isButton)
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring())
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                    self.hapticFeedback.prepare()           // prepare haptic engine
                }
                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        if self.offset.width < 0 {          // only play feedback on wrong answers
                            self.hapticFeedback.notificationOccurred(.error)
                        }
                        
                        self.removal?()
                    } else {
                        self.offset = .zero
                    }
                }
        )
    }
    
    func opacity(for offset: CGSize, after units: Int) -> Double {
        let noFadeValue: Double = 1 + Double(units / 100)
        return noFadeValue - Double(abs(offset.width / CGFloat(units / 2)))
    }
}

struct FlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardView(card: Flashcard.example)
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
