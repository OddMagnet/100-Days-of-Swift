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
                self.gameRunning.toggle()
            }
        }
    }
}

struct GameView: View {
    // state
    @Binding var gameRunning: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Button("Settings") {
                self.gameRunning.toggle()
            }
        }
        .navigationBarTitle("MathFun")
    }
}

struct ContentView: View {
    // state
    @State private var gameRunning = false
    // settings
    @State private var tablesUpTo = 4
    @State private var selectedAmount = 0
    let questionAmounts = [5, 10, 15, 20]
    
    
    var body: some View {
        NavigationView {
            if gameRunning {
                GameView(
                    gameRunning: $gameRunning
                )
            } else {
                SettingsView(
                    gameRunning: $gameRunning,
                    tablesUpTo: $tablesUpTo,
                    selectedAmount: $selectedAmount,
                    questionAmounts: questionAmounts
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
