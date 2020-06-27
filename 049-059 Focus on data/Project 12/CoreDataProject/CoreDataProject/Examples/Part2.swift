//
//  Part2.swift
//  CoreDataProject
//
//  Created by Michael Brünen on 27.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Part2: View {
    var body: some View {
        Section(header: Text("Part 2")) {
            
            NavigationLink("Filtering @FetchRequest using NSPredicate", destination:
                Text("1")
            )
            
            NavigationLink("Dynamically filtering @FetchRequest with SwiftUI", destination:
                Text("2")
            )
            
            NavigationLink("One-to-many relationships with Core Data, SwiftUI, and @FetchRequest", destination:
                Text("3")
            )
            
        }
    }
}

struct Part2_Previews: PreviewProvider {
    static var previews: some View {
        Part2()
    }
}
