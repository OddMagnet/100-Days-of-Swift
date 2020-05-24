//
//  ContentView.swift
//  WeSplit
//
//  Created by Michael Brünen on 24.05.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"] // no need for @State since its a constant
    @State private var selectedStudent = 0      // can change, so @State is needed

    var body: some View {
        VStack {
            // Labels are important for clarity, but for Screenreaders too
            Picker("Select your student", selection: $selectedStudent) {
                ForEach(0 ..< students.count) {
                    // create a text view for each student
                    Text(self.students[$0]) // two-way binding so it updates the selection
                }
            }
            Text("You chose: Student # \(students[selectedStudent])")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
