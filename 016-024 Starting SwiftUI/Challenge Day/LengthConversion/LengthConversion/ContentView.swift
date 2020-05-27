//
//  ContentView.swift
//  LengthConversion
//
//  Created by Michael Brünen on 27.05.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI


struct UnitSelection: View {
    let name: String
    let units: [String]
    var unitSelection: Binding<Int>
    
    var body: some View {
        Picker("aaa\(name)", selection: unitSelection) {
            ForEach(0 ..< units.count) {
                Text(self.units[$0])
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct ContentView: View {
    // State variables
    @State private var lengthValue = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    
    // properties
    let units = [
        UnitLength.meters,
        UnitLength.kilometers,
        UnitLength.feet,
        UnitLength.yards,
        UnitLength.miles
    ]
    let unitsAsStrings = [
        "meters",
        "kilometers",
        "feet",
        "yards",
        "miles"
    ]

    // computed properties
    var convertedUnit: Double {
        let length = Double(lengthValue) ?? 0.0
        let inputValue = Measurement(value: length, unit: units[inputUnit])
        let outputValue = inputValue.converted(to: units[outputUnit])
        return outputValue.value    // only return the value, not the Measurement type
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    TextField("Length value", text: $lengthValue)
                        .keyboardType(.decimalPad)
                    
                    // custom views to keep code DRY
                    UnitSelection(name: "Input unit", units: unitsAsStrings, unitSelection: $inputUnit)
                }
                .font(.headline)
                
                Section(header: Text("Output")) {
                    // custom views to keep code DRY
                    UnitSelection(name: "Output unit", units: unitsAsStrings, unitSelection: $outputUnit)
                    
                    Text("\(convertedUnit, specifier: "%.2f") \(unitsAsStrings[outputUnit])")
                }
                .font(.headline)
            }
            .navigationBarTitle("LengthConversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
