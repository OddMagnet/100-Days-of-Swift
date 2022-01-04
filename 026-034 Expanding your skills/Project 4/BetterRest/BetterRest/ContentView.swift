//
//  ContentView.swift
//  BetterRest
//
//  Created by Michael Brünen on 31.05.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // state
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
        
    // computed properties
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    var idealBedtime: String {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60     // hours -> seconds
        let minute = (components.minute ?? 0) * 60      // minutes -> seconds
        
        do {
            // get a prediction for how much sleep is needed
            let prediction = try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount)
            )
            // calculate when to go to bed (subtracting seconds from wakeUp)
            let sleepTime = wakeUp - prediction.actualSleep
            
            // format sleepTime
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: sleepTime)
            
        } catch {
            return "Calculation error"
        }
    }
    var sleepAmountVoiceOver: String {
        let hours = Int(sleepAmount)
        let minutes = Int((sleepAmount - Double(hours)) * 60)
        return "\(hours) hours\(minutes > 0 ? "and \(minutes) minutes" : "")"
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    //  .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desired amount of sleep")) {
                    
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                    .accessibility(label: Text(sleepAmountVoiceOver))
                }
                
                Section(header: Text("Daily coffee intake")) {
                    
                    Picker("Daily coffee intake (cups)", selection: $coffeeAmount) {
                        ForEach(0 ..< 21) {
                            Text("\($0)")
                            .accessibility(label: Text("\($0) cups"))
                        }
                    }
                }
                
                Section(header: Text("Ideal bedtime")) {
                    Text(idealBedtime)
                        .font(.title3)
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
