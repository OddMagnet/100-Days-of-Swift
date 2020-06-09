//
//  SettingsView.swift
//  iMultiply
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
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Spacer()
                
                Text("Multiplication tables")
                    .font(.title)
                Stepper("Up to... \(Int(tablesUpTo))", value: $tablesUpTo, in: 4...20)
                    .padding()
                
                Spacer()
                
                Text("How many questions?")
                    .font(.title)
                Picker("Questions", selection: $selectedAmount) {
                    ForEach(0 ..< questionAmounts.count) {
                        Text("\(self.questionAmounts[$0])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Spacer()
                Spacer()
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Start") {
                self.gameRunning.toggle()
            }
            .foregroundColor(.blue)
            )
        }
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
