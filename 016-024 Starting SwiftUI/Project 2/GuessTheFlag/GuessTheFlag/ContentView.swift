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
    @State private var countries = allCountries.shuffled()      // randomize flag order
    @State private var correctAnswer = Int.random(in: 0...2)    // correct flag is chosen randomly
    // Game over
    @State private var questionCounter = 1
    @State private var showingResults = false
    
    // Adding accessibilitay
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    let needsThe = ["UK", "US"]
    static let allCountries = [
        "Estonia", "France", "Germany", "Ireland", "Italy",
        "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
    ]

    
    // Project 6 - Wrap up challenge variables
    @State private var rotationAngle: Double = 0.0
    @State private var wrongFlagTapped = false
    
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
                            .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown Flag"]))
                    }
                    // Project 6 - Challenge 1 - spin the correct flag when tapped
                    .rotation3DEffect(
                        .degrees(number == self.correctAnswer ? self.rotationAngle : 0),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    // Project 6 - Challenge 2 - lower opacity of wrong flags
                    .opacity(self.showingScore && number != self.correctAnswer ? 0.25 : 1)
                    // Project 6 - Challenge 3 - scale down wrong flags when one is tapped
                    .scaleEffect(
                        self.showingScore && self.wrongFlagTapped && number != self.correctAnswer
                            ? 0.5
                            : 1.0
                    )
                    .animation(.easeInOut, value: 1.25)
                }
                Text("Your score: \(score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert("Game over!", isPresented: $showingResults) {
            Button("Start Again", action: newGame)
        } message: {
            Text("Your final score was \(score).")
        }
    }
    
    // set alert title after flag was tapped, then show it
    func flagTapped(_ number: Int) {
        let userAnswer = countries[number]

        if number == correctAnswer {
            rotationAngle += 360
            self.scoreTitle = "Correct"
            self.score += 2
            self.scoreMessage = "That is the flag of\(needsThe.contains(userAnswer) ? "the " : " ")\(countries[number]).\n Your score is: \(score)"
        } else {
            wrongFlagTapped = true
            self.scoreTitle = "Wrong"
            self.score -= 1
            self.scoreMessage = "That was the flag of\(needsThe.contains(userAnswer) ? "the " : " ")\(countries[number]).\n Your score is: \(score)"
        }

        if questionCounter == 8 {
            showingResults = true
        } else {
            showingScore = true
        }
    }
    
    // randomize for the next question
    func askQuestion() {
        // remove previous correct answer before resetting state
        countries.remove(at: correctAnswer)

        // reset states used for animations
        rotationAngle = 0
        wrongFlagTapped = false
        
        // reset the game
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter += 1
    }

    // starts a new game
    func newGame() {
        questionCounter = 0
        score = 0
        countries = Self.allCountries.shuffled()
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
