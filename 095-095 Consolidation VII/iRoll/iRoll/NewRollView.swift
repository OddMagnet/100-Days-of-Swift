//
//  NewRollView.swift
//  iRoll
//
//  Created by Michael Brünen on 25.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct NewRollView: View {
    @EnvironmentObject var settings: Settings
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: DiceRoll.entity(), sortDescriptors: []) var diceRolls: FetchedResults<DiceRoll>
    @State private var results = [Int](repeating: 0, count: Settings.maxDiceAmount)
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Amount: \(settings.diceAmount)")
                    Spacer()
                    Text("Sides: \(settings.diceSides)")
                }
                .padding()
                       
                Text("Total: \(results.reduce(0, +))")
                    .font(.title)
                
                List {
                    ForEach(0 ..< settings.diceAmount, id: \.self) { dice in
                        HStack {
                            Spacer()
                            Text("\(self.results[dice])")
                            Spacer()
                        }
                    }
                }
                
                Button("   Roll   ") {
                    self.rollDice()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .clipShape(Capsule())
                .padding(.bottom)
            }
            .navigationBarTitle("New Roll")
        }
        .onAppear {
            self.results = [Int](repeating: 0, count: self.settings.diceAmount)
        }
    }
    
    func rollDice() {
        // dispatch group so saving can be done after dices have stopped rolling
        let group = DispatchGroup()
        
        // roll the dices, each dice roll has a random amount of rotations
        // every rotation is a block that enters the group and exits after the rotation is done
        for dice in 0 ..< settings.diceAmount {
            let rotations = Int.random(in: 2...12)
            for i in 0 ..< rotations {
                group.enter()
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds((rotations - i) * 200)) {
                    self.results[dice] = Int.random(in: 1...self.settings.diceSides)
                    group.leave()
                }
            }
        }
        
        // after all blocks have left the group (all rotations are done, rolls are final), the rolls will be saved
        group.notify(queue: .main) {
            let newRoll = DiceRoll(context: self.moc)
            newRoll.rolls = self.results
            newRoll.sides = Int16(self.settings.diceSides)
            do {
                try self.moc.save()
            } catch {
                print("Error saving new roll")
                print(error.localizedDescription)
            }
        }
    }
}

struct NewRollView_Previews: PreviewProvider {
    @ObservedObject static var settings = Settings()
    static var previews: some View {
        settings.diceAmount = 6
        settings.diceSides = 12
        return NewRollView().environmentObject(settings)
    }
}
