//
//  ContentView.swift
//  LengthConversion
//
//  Created by Michael Brünen on 27.05.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // State variables
    @State private var input = 100.0
    @State private var inputUnit: Dimension = UnitLength.meters
    @State private var outputUnit: Dimension = UnitLength.kilometers
    @State private var selectedUnitType: Int = 0                        // selects the sub-array of `unitTypes`
    @FocusState private var inputIsFocused: Bool

    // properties
    let conversions = ["Distance", "Mass", "Temperature", "Time"]
    let unitTypes = [
        [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles],
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]
    ]
    let formatter: MeasurementFormatter

    // computed properties
    var result: String {
        let inputMeasurement = Measurement(value: input, unit: inputUnit)
        let outputMeasurement = inputMeasurement.converted(to: outputUnit)
        return formatter.string(from: outputMeasurement)
    }

    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Conversion of")) {
                    Picker("Conversion", selection: $selectedUnitType) {
                        ForEach(0 ..< conversions.count) {
                            Text(conversions[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Input")) {
                    TextField("Amount", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)

                    // custom views to keep code DRY
                    UnitSelection(name: "Convert from", units: unitTypes[selectedUnitType], unitSelection: $inputUnit)
                }
                .font(.headline)
                
                Section(header: Text("Result")) {
                    // custom views to keep code DRY
                    UnitSelection(name: "Convert to", units: unitTypes[selectedUnitType], unitSelection: $outputUnit)

                    Text(result)
                }
                .font(.headline)
            }
            .navigationBarTitle("LengthConversion")
            .onChange(of: selectedUnitType) { newSelection in
                let units = unitTypes[newSelection]
                inputUnit = units[0]
                outputUnit = units[1]
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }

    func UnitSelection(name: String, units: [Dimension], unitSelection: Binding<Dimension>) -> some View {
        Picker("\(name)", selection: unitSelection) {
            ForEach(units, id: \.self) {
                Text(formatter.string(from: $0).capitalized)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
