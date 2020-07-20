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
    let card: Flashcard
    
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
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
    }
}

struct FlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardView(card: Flashcard.example)
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
