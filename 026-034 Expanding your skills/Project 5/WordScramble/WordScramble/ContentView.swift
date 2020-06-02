//
//  ContentView.swift
//  WordScramble
//
//  Created by Michael Brünen on 02.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        VStack {
            Section(header: Text("mixed list")) {
                List {
                    Section(header: Text("Section 1")) {
                        Text("Static - 1")
                        Text("Static - 2")
                    }
                    Section(header: Text("Section 2")) {
                        ForEach(0 ..< 3) {
                            Text("Dynamic - \($0)")
                        }
                    }
                    Section(header: Text("Static - 3")) {
                        Text("Static - 3")
                        Text("Static - 4")
                    }
                    Section(header: Text("id example")) {
                        ForEach(people, id: \.self) {
                            Text($0)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
