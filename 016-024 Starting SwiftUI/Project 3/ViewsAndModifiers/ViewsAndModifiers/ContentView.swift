//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Michael Brünen on 30.05.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // Example of why modifier order matters
            Text("Background -> Frame")
                .background(Color.red)
                .frame(width: 200, height: 30)
            Text("Frame -> Background")
                .frame(width: 200, height: 30)
                .background(Color.green)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
