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
    @State private var numberOfPeople = ""      // how many are sharing the cost
    @State private var tipPercentage = 2        // how much of a tip will be left
    
    // Constants
    let tipPercentages = [10, 15, 20, 25, 0]    // holds values for the tip picker
    
    // Computed properties
    // calculates the grand total
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])

        let orderAmount = Double(checkAmount) ?? 0      // using nil coalescing to ensure a safe value
        let tipValue = orderAmount / 100 * tipSelection
        
        return orderAmount + tipValue
    }
    
    // calculates the amount each person has to pay, tip included
    var totalPerPerson: Double {
        let peopleCount = Int(numberOfPeople) ?? 1      // convert to int (whole people), ensure a safe value
        
        let amountPerPerson = grandTotal / Double(peopleCount)
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    // TextField view with a placeholder text and two-way binding to the state property
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)  // only show a decimal keypad to avoid non-digits
                                        
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)   // no decimals needed, only whole people
                    
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    // Picker view for the tip percentage selection
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            // create a 'row' for every tip percentage option
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())    // best suited for fewer items
                }
                
                Section(header: Text("Total amoount")) {
                    // display the total amount of the check
                    Text("$\(grandTotal, specifier: "%.2f")")
                        // Project 3 Wrap up - Challenge 2
                        .foregroundColor(tipPercentage == 4 ? .red : .primary)
                }
                
                Section(header: Text("Amount per person")) {
                    // display the total amount per person, specifier reduces digits after comma to 2
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
