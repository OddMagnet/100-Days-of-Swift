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
   
    @State private var lastNameFilter = "A"
    
    @FetchRequest(
        entity: Country.entity(),
        sortDescriptors: []
    ) var countries: FetchedResults<Country>
    
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
                VStack {
                    FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                        Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                    }

                    Button("Add Examples") {
                        let taylor = Singer(context: self.moc)
                        taylor.firstName = "Taylor"
                        taylor.lastName = "Swift"

                        let ed = Singer(context: self.moc)
                        ed.firstName = "Ed"
                        ed.lastName = "Sheeran"

                        let adele = Singer(context: self.moc)
                        adele.firstName = "Adele"
                        adele.lastName = "Adkins"

                        try? self.moc.save()
                    }

                    Button("Show A") {
                        self.lastNameFilter = "A"
                    }

                    Button("Show S") {
                        self.lastNameFilter = "S"
                    }
                }
            )
            
            NavigationLink("One-to-many relationships with Core Data, SwiftUI, and @FetchRequest", destination:
                VStack {
                    List {
                        ForEach(countries, id: \.self) { country in
                            Section(header: Text("\(country.wrappedFullName) (\(country.wrappedShortName))")) {
                                ForEach(country.candyArray, id: \.self) { candy in
                                    Text(candy.wrappedName)
                                }
                            }
                        }
                    }
                    
                    Button("Add") {
                        let candy1 = Candy(context: self.moc)
                        candy1.name = "Mars"
                        candy1.origin = Country(context: self.moc)
                        candy1.origin?.shortName = "UK"
                        candy1.origin?.fullName = "United Kingdom"

                        let candy2 = Candy(context: self.moc)
                        candy2.name = "KitKat"
                        candy2.origin = Country(context: self.moc)
                        candy2.origin?.shortName = "UK"
                        candy2.origin?.fullName = "United Kingdom"

                        let candy3 = Candy(context: self.moc)
                        candy3.name = "Twix"
                        candy3.origin = Country(context: self.moc)
                        candy3.origin?.shortName = "UK"
                        candy3.origin?.fullName = "United Kingdom"

                        let candy4 = Candy(context: self.moc)
                        candy4.name = "Toblerone"
                        candy4.origin = Country(context: self.moc)
                        candy4.origin?.shortName = "CH"
                        candy4.origin?.fullName = "Switzerland"

                        try? self.moc.save()
                    }
                }
            )
                        
        }
    }
}

struct Part2_Previews: PreviewProvider {
    static var previews: some View {
        Part2()
    }
}
