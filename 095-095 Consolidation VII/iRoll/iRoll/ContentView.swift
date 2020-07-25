//
//  ContentView.swift
//  iRoll
//
//  Created by Michael Brünen on 25.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: DiceRoll.entity(), sortDescriptors: []) var diceRolls: FetchedResults<DiceRoll>
    
    @State private var diceSides: Int = 6
    @State private var diceAmount: Int = 1
    
    var body: some View {
        TabView {
            Text("\(diceAmount) x \(diceSides)-sided dice")
                .tabItem {
                    Image(systemName: "hexagon")
                    Text("New Roll")
            }
            
            Text("Past Rolls")
                .tabItem {
                    Image(systemName: "hexagon.fill")
                    Text("Past Rolls")
            }
            
            SettingsView(sides: $diceSides, amount: $diceAmount)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
