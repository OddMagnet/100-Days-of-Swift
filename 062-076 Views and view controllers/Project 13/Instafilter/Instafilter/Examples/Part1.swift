//
//  Part1.swift
//  Instafilter
//
//  Created by Michael Brünen on 30.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Part1: View {
    @State private var blurAmount: CGFloat = 0
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        // a custom binding allows for 'observing' of a state property and reacting on it's change in the setter
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )
        
        return Section(header: Text("Part 1")) {
            
            NavigationLink("How property wrappers become structs", destination:
                Text(
                    """
When using 'didSet' on a state property, the code inside it will never be run.
Behind the scenes property wrappers are jusr structs that wrap around a value.
Since structs usually can't be changed these property wrappers use the 'nonmutating' keyword for the setter.
This tells Swift to not actually change the struct itself when the value is changed.
This is why 'didSet' does not work with propert wrappers
"""
                )
                    .padding()
            )
            
            NavigationLink("Creating custom bindings in SwiftUI", destination:
                VStack {
                    Text(
                        """
For this blur a custom binding is used, which practically acts as a passthrough to the actual @State property.
This allows for code to be executed on setting a new value.
The .blur modifier on this text uses the @State property directly, the slider on the other hand uses the binding.
Whenever the slider is moved the setter of the binding is called, the @State property is set and the new value is printed.
"""
                    )
                        .blur(radius: blurAmount)

                    Slider(value: blur, in: 0...20)
                }
                .padding()
            )
            
            NavigationLink("Showing multiple options with ActionSheet", destination:
                VStack {
                    Text("Tap me, please!")
                        .frame(width: 300, height: 300)
                        .background(backgroundColor)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                }
                .padding()
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
                        .default(Text("Red")) { self.backgroundColor = .red },
                        .default(Text("Green")) { self.backgroundColor = .green },
                        .default(Text("Blue")) { self.backgroundColor = .blue },
                        .cancel()
                    ])
                }
            )
        }
    }
}

struct Part1_Previews: PreviewProvider {
    static var previews: some View {
        Part1()
    }
}
