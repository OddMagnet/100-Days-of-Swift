//
//  GameView.swift
//  MathFun
//
//  Created by Michael Brünen on 08.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct GameView: View {
    // state
    @Binding var gameRunning: Bool
    @Binding var questions: [Question]
    @State private var currentQuestion = 0
    
    var body: some View {
        VStack {
            Text(questions[currentQuestion].question)
            Spacer()
            Button("Settings") {
                self.gameRunning.toggle()
            }
        }
        .navigationBarTitle("MathFun")
        .navigationBarItems(trailing: Button("Settings") {
            self.gameRunning.toggle()
        })
    }
}


struct GameView_Previews: PreviewProvider {
    @State static var gameRunning = true
    @State static var questions = [Question(question: "Test", answer: 42)]
    static var previews: some View {
        GameView(
            gameRunning: $gameRunning,
            questions: $questions
        )
    }
}
