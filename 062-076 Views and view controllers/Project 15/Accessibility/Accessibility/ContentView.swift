//
//  ContentView.swift
//  Accessibility
//
//  Created by Michael Brünen on 09.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]
    @State private var selectedPicture = Int.random(in: 0...3)
    @State private var estimate = 25.0
    
    var body: some View {
        VStack {
            Spacer()
            Image(pictures[selectedPicture])
                .resizable()
                .scaledToFit()
                .accessibility(label: Text(labels[selectedPicture]))
                .accessibility(addTraits: .isButton)
                .onTapGesture {
                    self.selectedPicture = Int.random(in: 0...3)
            }
            
            Spacer()
            
            HStack {
                Text("Filling")
                Spacer()
                Text("the screen")
            }
            .padding()
            .accessibilityElement(children: .ignore)
            .accessibility(label: Text("Filling the screen"))
            
            Spacer()
            
            Slider(value: $estimate, in: 0...50)
                .padding()
                .accessibility(value: Text("\(Int(estimate))"))
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
