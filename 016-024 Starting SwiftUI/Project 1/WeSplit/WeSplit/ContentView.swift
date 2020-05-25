//
//  ContentView.swift
//  WeSplit
//
//  Created by Michael Brünen on 24.05.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // State properties
    @State private var checkAmount = ""         // cost of the check
    // Double would be better for numbers, but SwiftUI only allows strings in text views
    @State private var numberOfPeople = 2       // how many are sharing the cost
    @State private var tipAmount = 2            // how much of a tip will be left
    
    // Constants
    let tipPercentages = [10, 15, 20, 25, 0]    // holds values for the tip picker
    
    var body: some View {
        Form {
            Section {
                // TextField view with a placeholder text and two-way binding to the state property
                TextField("Amount", text: $checkAmount)
                    .keyboardType(.decimalPad)  // only show a decimal keypad to avoid non-digits
            }
            Section {
                Text("$\(checkAmount)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
