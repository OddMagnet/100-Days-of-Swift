//
//  ContentView.swift
//  iMultiply
//
//  Created by Michael Brünen on 08.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

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
                if gameRunning {
                    GameView(
                        gameRunning: $gameRunning,
                        questions: $questions
                    )
                        .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
                        .animation(.default)
                        .onAppear(perform: startGame)
                } else {
                    SettingsView(
                        gameRunning: $gameRunning,
                        tablesUpTo: $tablesUpTo,
                        selectedAmount: $selectedAmount,
                        questions: $questions,
                        questionAmounts: questionAmounts
                    )
                        .transition(.move(edge: .bottom))
                        .animation(.default)
                }
            }
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
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
