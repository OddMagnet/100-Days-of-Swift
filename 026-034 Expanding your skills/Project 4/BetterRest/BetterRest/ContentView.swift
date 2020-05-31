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
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    
    var body: some View {
        NavigationView {
            Form {
                // Stepper example
                Stepper(value: $sleepAmount, in: 2...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") hours")
                }
                
                // DatePicker example
                DatePicker("Please pick a date",                // label
                           selection: $wakeUp,                  // binding
                           in: Date()...,                       // only display future dates
                           displayedComponents: .hourAndMinute
                )
                
                // Working with dates example
                Text("\(getHourAndMinuteString(from: wakeUp)) from now")
                Text("\(getFormattedDateString(from: wakeUp))")
            }
            .navigationBarTitle("BetterRest")
        }
    }
    
    // Working with dates example
    func getHourAndMinuteString(from: Date) -> String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        return "\(hour) hours and \(minute) minutes"
    }
    func getFormattedDateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
