//
//  Part2.swift
//  Flashzilla
//
//  Created by Michael Brünen on 18.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Part2: View {
    var body: some View {
        Section(header: Text("Part 2")) {
            
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

struct Part2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Part2()
            }
            .navigationBarTitle("Examples")
        }
    }
}
