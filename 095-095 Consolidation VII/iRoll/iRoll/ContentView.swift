//
//  ContentView.swift
//  iRoll
//
//  Created by Michael Brünen on 25.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

class Settings: ObservableObject {
    @Published var diceSides: Int = 6
    @Published var diceAmount: Int = 1
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: DiceRoll.entity(), sortDescriptors: []) var diceRolls: FetchedResults<DiceRoll>
    @ObservedObject var settings = Settings()
    
    var body: some View {
        TabView {
            Text("\(settings.diceAmount) x \(settings.diceSides)-sided dice")
                .tabItem {
                    Image(systemName: "hexagon")
                    Text("New Roll")
            }
            
            Text("Past Rolls")
                .tabItem {
                    Image(systemName: "hexagon.fill")
                    Text("Past Rolls")
            }
            
            SettingsView().environmentObject(settings)
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
