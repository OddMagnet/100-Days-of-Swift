//
//  SettingsView.swift
//  iRoll
//
//  Created by Michael Brünen on 25.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: Settings
    @State private var sideSelection = 1
    @State private var amountSelection = 1
    
    var possibleSides = [4, 6, 8, 12, 20, 100]
    
    var body: some View {
        
        let sideBinding = Binding<Int>(
            get: { self.sideSelection },
            set: {
                self.sideSelection = $0
                self.settings.diceSides = self.possibleSides[$0]
            }
        )
        
        let amountBinding = Binding<Int>(
            get: { self.amountSelection },
            set: {
                self.amountSelection = $0
                self.settings.diceAmount = $0
            }
        )
        
        return NavigationView {
            Form {
                Section(header: Text("Sides")) {
                    Picker(selection: sideBinding, label: Text("Sides of the dies")) {
                        ForEach(0 ..< possibleSides.count) {
                            Text("\(self.possibleSides[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount of dice (1...\(Settings.maxDiceAmount))")) {
                    Stepper("\(amountSelection)", value: amountBinding, in: 1...Settings.maxDiceAmount)
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
            SettingsView()//sides: .constant(6), amount: .constant(2))
    }
}
