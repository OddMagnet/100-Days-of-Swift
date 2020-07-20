//
//  FlashcardView.swift
//  Flashzilla
//
//  Created by Michael Brünen on 20.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct FlashcardView: View {
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    let card: Flashcard
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .circular)
                .fill(Color.white)
                .shadow(radius: 10)
            
            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5))) // rotate slowly, 1/5 of the actual movement
        .offset(x: offset.width * 5, y: 0)                  // move fast horiziontally, 5x the movement
        .opacity(opacity(for: offset, after: 100))          // opacity goes down after 50 units
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
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
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
