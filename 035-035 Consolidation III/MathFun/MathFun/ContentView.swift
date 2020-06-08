//
//  ContentView.swift
//  MathFun
//
//  Created by Michael Brünen on 08.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    // state
    @Binding var gameRunning: Bool
    @Binding var tablesUpTo: Int
    @Binding var selectedAmount: Int
    @Binding var questions: [Question]
    
    var questionAmounts: [Int]
    
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Multiplication tables")) {
                    Stepper("Up to... \(Int(tablesUpTo))", value: $tablesUpTo, in: 4...20)
                }
                Section(header: Text("How many questions?")) {
                    Picker("Questions", selection: $selectedAmount) {
                        ForEach(0 ..< questionAmounts.count) {
                            Text("\(self.questionAmounts[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                Section(header: Text("Summary")) {
                    Text("\(questionAmounts[selectedAmount]) questions with a range of up to \(tablesUpTo)")
                }
                
            }
            .navigationBarTitle("Settings")
            Button("START") {
                self.startGame()
            }
        }
    }
    
    func startGame() {
        // reset questions array
        questions = [Question]()
        // then create new ones
        for _ in 0 ..< selectedAmount {
            let x = Int.random(in: 1...tablesUpTo)
            let y = Int.random(in: 1...tablesUpTo)
            questions.append(Question(question: "What is \(x) x \(y)?", answer: x*y))
        }
        print(questions)
        // and start the game
        //self.gameRunning.toggle()
    }

}

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
    }
}

struct Question {
    let question: String
    let answer: Int
}

struct ContentView: View {
    // state
    @State private var gameRunning = false
    
    // settings
    @State private var tablesUpTo = 4
    @State private var selectedAmount = 0
    let questionAmounts = [5, 10, 15, 20]
    
    // game
    @State private var questions = [Question(question: "Test", answer: 42)]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Game is running: \(gameRunning ? "true" : "false")")
                if gameRunning {
                    GameView(
                        gameRunning: $gameRunning,
                        questions: $questions
                    )
                } else {
                    SettingsView(
                        gameRunning: $gameRunning,
                        tablesUpTo: $tablesUpTo,
                        selectedAmount: $selectedAmount,
                        questions: $questions,
                        questionAmounts: questionAmounts
                    )
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
