//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Michael Brünen on 28.05.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var normalTapped = 0
    @State private var customTapped = 0
    
    var body: some View {
        VStack {
            Button("Normal button") {
                self.normalTapped += 1
            }
            Button(action: {
                self.customTapped += 1
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "pencil")
                    Text("Custom button")
                }
            }
            Text("Normal taps: \(normalTapped), Custom taps: \(customTapped)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
