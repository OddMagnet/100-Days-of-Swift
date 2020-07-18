//
//  Part1.swift
//  Flashzilla
//
//  Created by Michael Brünen on 18.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Part1: View {
    var body: some View {
        Section(header: Text("Part 1")) {
            
            NavigationLink("Placeholder 1", destination:
                Text("Placeholder 1")
            )

            NavigationLink("Placeholder 2", destination:
                Text("Placeholder 2")
            )

            NavigationLink("Placeholder 3", destination:
                Text("Placeholder 3")
            )
        }
    }
}

struct Part1_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Part1()
            }
            .navigationBarTitle("Examples")
        }
    }
}
