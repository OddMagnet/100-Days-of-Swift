//
//  Part1.swift
//  BucketList
//
//  Created by Michael Brünen on 04.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Part1: View {
    var body: some View {
        Section(header: Text("Part 1")) {
            
            NavigationLink("Adding conformance to Comparable for custom types", destination:
                Text("1")
            )
            
            NavigationLink("Writing data to the documents directory", destination:
                Text("2")
            )

            NavigationLink("Switching view states with enums", destination:
                Text("3")
            )

        }
    }
}

struct Part1_Previews: PreviewProvider {
    static var previews: some View {
        Part1()
    }
}
