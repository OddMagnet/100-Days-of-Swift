//
//  Part2.swift
//  CoreDataProject
//
//  Created by Michael Brünen on 27.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import CoreData
import SwiftUI

struct Part2: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Ship.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "universe == %@", "Star Wars")
    ) var ships: FetchedResults<Ship>
    
    var body: some View {
        Section(header: Text("Part 2")) {
            
            NavigationLink("Filtering @FetchRequest using NSPredicate", destination:
                VStack {
                    List(ships, id: \.self) { ship in
                        Text(ship.name ?? "Unknown name")
                    }
                    
                    Button("Add Examples") {
                        let ship1 = Ship(context: self.moc)
                        ship1.name = "Enterprise"
                        ship1.universe = "Star Trek"

                        let ship2 = Ship(context: self.moc)
                        ship2.name = "Defiant"
                        ship2.universe = "Star Trek"

                        let ship3 = Ship(context: self.moc)
                        ship3.name = "Millennium Falcon"
                        ship3.universe = "Star Wars"

                        let ship4 = Ship(context: self.moc)
                        ship4.name = "Executor"
                        ship4.universe = "Star Wars"

                        try? self.moc.save()
                    }
                }
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
