//
//  ContentView.swift
//  iRoll
//
//  Created by Michael Brünen on 25.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

class Settings: ObservableObject {
    static let maxDiceAmount = 6
    @Published var diceSides: Int = 6
    @Published var diceAmount: Int = 1
}

struct ContentView: View {
    @ObservedObject var settings = Settings()
    
    var body: some View {
        TabView {
            NewRollView().environmentObject(settings)
                .tabItem {
                    Image(systemName: "hexagon")
                    Text("New Roll")
            }
            
            PastRollsView()
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
