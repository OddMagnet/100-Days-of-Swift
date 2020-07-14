//
//  Part3.swift
//  HotProspects
//
//  Created by Michael Brünen on 14.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Part3: View {
    var body: some View {
        Section(header: Text("Part 3")) {
            
            NavigationLink("Placeholder", destination:
                Text("Placeholder")
            )
        }
    }
}

struct Part3_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Part3()
            }
        }
    }
}
