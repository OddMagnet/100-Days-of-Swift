//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Michael Brünen on 28.05.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

// Project 3 Wrap up - Challenge 3
struct FlagImage: View {
    let name: String
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.blue, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    // state
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy",
        "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
        ].shuffled()                                            // randomize flag order
    @State private var correctAnswer = Int.random(in: 0...2)    // correct flag is chosen randomly
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                Spacer()
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in        // create flag images as buttons
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        // Project 3 Wrap up - Challenge 3
                        FlagImage(name: self.countries[number])
                    }
                }
                Text("Your score: \(score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    // set alert title after flag was tapped, then show it
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            self.scoreTitle = "Correct"
            self.score += 2
            self.scoreMessage = "That is the flag of \(countries[number]).\n Your score is: \(score)"
        } else {
            self.scoreTitle = "Wrong"
            self.score -= 1
            self.scoreMessage = "That was the flag of \(countries[number]).\n Your score is: \(score)"
        }
        showingScore = true
    }
    
    // randomize for the next question
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
