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
        for dice in 0 ..< settings.diceAmount {
            results[dice] = Int.random(in: 1...settings.diceSides)
        }
        let newRoll = DiceRoll(context: self.moc)
        newRoll.rolls = results
        newRoll.sides = Int16(settings.diceSides)
        do {
            try self.moc.save()
        } catch {
            print("Error saving new roll")
            print(error.localizedDescription)
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
