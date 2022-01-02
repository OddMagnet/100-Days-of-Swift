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
    @State private var computerChoice = Int.random(in: 0 ..< 3)
    @State private var shouldWin = Bool.random()
    @State private var currentRound = 1
    @State private var playerScore = 0
    @State private var showingGameOver = false
    
    // properties
    enum Play: String {
        case Rock = "✊"
        case Paper = "✋"
        case Scissors = "✌️"
    }
    let possibleChoices: [Play] = [.Rock, .Paper, .Scissors]
    
    // methods
    func newRound() {
        computerChoice = Int.random(in: 0 ..< 3)
        shouldWin = Bool.random()
    }
    
    func newGame() {
        currentRound = 1
        playerScore = 0
        newRound()
    }

    func play(choice: Int) {
        let winningMoves = [1, 2, 0]
        let didWin: Bool

        // check if the player made the correct choice
        if shouldWin {
            didWin = choice == winningMoves[computerChoice]
        } else {
            didWin = winningMoves[choice] == computerChoice
        }

        // adjust the score accordingly
        if didWin {
            playerScore += 1
        } else {
            playerScore -= 1
        }

        // check if the game is over
        if currentRound == 10 {
            showingGameOver = true
        } else {
            currentRound += 1
            newRound()
        }
    }

    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                Text("Current round: \(currentRound)/10")
                Text(possibleChoices[computerChoice].rawValue)
                    .font(.title)
                
                HStack {
                    Text("Try to...")
                    Text(shouldWin ? "WIN!" : "LOOSE!")
                        .foregroundColor(shouldWin ? .green : .red)
                }
                
                ForEach(0 ..< 3){ choice in
                    Button(possibleChoices[choice].rawValue) {
                        play(choice: choice)
                    }
                    .alert("Game over", isPresented: $showingGameOver) {
                        Button("New round", action: newGame)
                    } message: {
                        Text("You scored \(self.playerScore)/10")
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
