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
