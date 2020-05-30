//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Michael Brünen on 30.05.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    // state properties
    @State private var currentChoice = Int.random(in: 0 ..< 3)
    @State private var shouldWin = Bool.random()
    @State private var currentRound = 1
    @State private var playerScore = 0
    @State private var showGameOver = false
    
    // properties
    enum Play: String {
        case Rock = "Rock"
        case Paper = "Paper"
        case Scissors = "Scissors"
    }
    let choices: [Play] = [.Rock, .Paper, .Scissors]
    
    // methods
    func didPlayerWin(with choice: Play) -> Bool {
        switch choice {
        case .Rock:
            return currentChoice == 2 ? true : false
        case .Paper:
            return currentChoice == 0 ? true : false
        case .Scissors:
            return currentChoice == 1 ? true : false
        }
    }
    
    func newRound() {
        currentChoice = Int.random(in: 0 ..< 3)
        shouldWin = Bool.random()
    }
    
    func newGame() {
        currentRound = 1
        playerScore = 0
        newRound()
    }

    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                Text("Current round: \(currentRound)/10")
                Text(choices[currentChoice].rawValue)
                    .font(.title)
                
                HStack {
                    Text("Try to...")
                    Text(shouldWin ? "WIN!" : "LOOSE!")
                        .foregroundColor(shouldWin ? .green : .red)
                }
                
                ForEach(0 ..< 3){ choice in
                    Button(self.choices[choice].rawValue) {
                        // increase score if player did as told
                        if self.didPlayerWin(with: self.choices[choice]) == self.shouldWin{
                            self.playerScore += 1
                        } else {
                            self.playerScore -= 1
                        }
                        
                        // show game over after 10 rounds
                        if self.currentRound == 10 {
                            self.showGameOver = true
                        } else {
                            // increase round counter and start new round
                            self.currentRound += 1
                            self.newRound()
                        }
                    }
                    .alert(isPresented: self.$showGameOver) {
                        Alert(
                            title: Text("Game over"),
                            message: Text("You scored \(self.playerScore)/10"),
                            dismissButton: .default(Text("New round"), action: {
                                self.newGame()
                            })
                        )
                    }
                    .font(.title)
                    .padding()
                    .frame(minWidth: 0, maxWidth: 200)
                    .background(Color.blue)
                    .foregroundColor(.white)
                }
                
                Spacer()
                
                Text("Score: \(playerScore)")
                    .font(.largeTitle)
                
                Spacer()
            }
            .navigationBarTitle("Rock, Paper, Scissors!?")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
