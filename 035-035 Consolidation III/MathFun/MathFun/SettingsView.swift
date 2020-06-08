//
//  SettingsView.swift
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
            .navigationBarItems(trailing: Button("START") {
                self.startGame()
            })
        }
    }
    
    func startGame() {
        // reset questions array
        questions = [Question]()
        // then create new ones
        for _ in 0 ..< questionAmounts[selectedAmount] {
            let x = Int.random(in: 1...tablesUpTo)
            let y = Int.random(in: 1...tablesUpTo)
            questions.append(Question(question: "What is \(x) x \(y)?", answer: x*y))
        }
        // and start the game
        self.gameRunning.toggle()
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    @State static var gameRunning = true
    @State static var tablesUpTo = 4
    @State static var selectedAmount = 0
    @State static var questions = [Question(question: "Test", answer: 42)]
    
    static var previews: some View {
        SettingsView(
            gameRunning: $gameRunning,
            tablesUpTo: $tablesUpTo,
            selectedAmount: $selectedAmount,
            questions: $questions,
            questionAmounts: [5, 10, 15, 20]
        )
    }
}
