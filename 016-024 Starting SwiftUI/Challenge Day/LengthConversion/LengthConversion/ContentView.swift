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
    @State private var inputUnit = UnitLength.meters
    @State private var outputUnit = UnitLength.kilometers
    @FocusState private var inputIsFocused: Bool

    // properties
    let units: [UnitLength] = [.meters, .kilometers, .feet, .miles, .yards]
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
                Section(header: Text("Input")) {
                    TextField("Amount", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    
                    // custom views to keep code DRY
                    UnitSelection(name: "Convert from", units: units, unitSelection: $inputUnit)
                }
                .font(.headline)
                
                Section(header: Text("Result")) {
                    // custom views to keep code DRY
                    UnitSelection(name: "Convert to", units: units, unitSelection: $outputUnit)

                    Text(result)
                }
                .font(.headline)
            }
            .navigationBarTitle("LengthConversion")
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

    func UnitSelection(name: String, units: [UnitLength], unitSelection: Binding<UnitLength>) -> some View {
        Picker("\(name)", selection: unitSelection) {
            ForEach(units, id: \.self) {
                Text(formatter.string(from: $0))
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
