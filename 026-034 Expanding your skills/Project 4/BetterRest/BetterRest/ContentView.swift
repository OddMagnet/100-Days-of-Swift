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
    
    var body: some View {
        VStack {
            // Stepper example
            Stepper(value: $sleepAmount, in: 2...12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%g") hours")
            }
            .frame(width: 300, height: 40)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
