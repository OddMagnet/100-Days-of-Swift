//
//  GameView.swift
//  iMultiply
//
//  Created by Michael Brünen on 08.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct GameView: View {
    // bindings
    @Binding var gameRunning: Bool
    @Binding var questions: [Question]
    
    // state
    @State private var currentQuestion = 0
    @State private var score = 0
    @State private var userAnswer = ""
    @State private var gameOver = false     // show alert after last question
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Question \(currentQuestion + 1)/\(questions.count)")
                .font(.headline)
            Text(questions[currentQuestion].question)
                .font(.largeTitle)
            TextField("Your answer", text: $userAnswer, onCommit: checkAnswer)
                .frame(width: 300, height: 40, alignment: .center)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            Spacer()
            Text("Score \(score)")
                .font(.title)
        }
        .navigationBarTitle("MathFun")
        .navigationBarItems(trailing: Button("Settings") {
            self.gameRunning.toggle()
        })
        .alert(isPresented: $gameOver) {
            Alert(title: Text("Game Over"),
                  message: Text("You answered all the questions"),
                  dismissButton: .cancel(Text("Menu")){
                    self.gameRunning = false
                })
        }
    }
    
    func checkAnswer() {
        // calculate new score
        if Int(userAnswer) == questions[currentQuestion].answer {
            score += 2
        } else {
            score -= 1
        }
        
        // show next question or gameOver
        if (currentQuestion + 1) == questions.count {
            gameOver = true
        } else {
            currentQuestion += 1
        }
        
        // reset textfield
        userAnswer = ""
    }
}


struct GameView_Previews: PreviewProvider {
    @State static var gameRunning = true
    @State static var questions = [Question(question: "What is 6 x 7", answer: 42)]
    static var previews: some View {
        GameView(
            gameRunning: $gameRunning,
            questions: $questions
        )
    }
}
