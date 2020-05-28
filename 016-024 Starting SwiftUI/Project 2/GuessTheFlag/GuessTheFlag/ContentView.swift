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
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            Button("Show alert") {
                self.showingAlert = true
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Hello SwiftUI!"), message: Text("This is some detail message"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
