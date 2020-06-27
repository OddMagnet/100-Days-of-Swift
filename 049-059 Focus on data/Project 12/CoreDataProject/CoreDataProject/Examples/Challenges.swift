//
//  Challenges.swift
//  CoreDataProject
//
//  Created by Michael Brünen on 27.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import CoreData
import SwiftUI


struct ChallengeFilteredList<T: NSManagedObject, Content: View>: View {
    enum Predicate: String {
        case beginsWith = "BEGINSWITH"
        case contains = "CONTAINS"
    }
    var fetchRequest: FetchRequest<T>
    var results: FetchedResults<T> { fetchRequest.wrappedValue }
    
    // content closure
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { result in
            self.content(result)
        }
    }
    
    init(filterKey: String,
         //filterPredicate: String,                 // Wrap up - Challenge 2
        filterPredicate: Predicate,                // Wrap up - Challenge 3
        filterValue: String,
        sortDescriptors: [NSSortDescriptor],       // Wrap up - Challenge 1
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        fetchRequest = FetchRequest<T>(
            entity: T.entity(),
            sortDescriptors: sortDescriptors,                       // Wrap up - Challenge 1
            predicate: NSPredicate(
                //format: "%K \(filterPredicate.uppercased()) %@",  // Wrap up - Challenge 2
                format: "%K \(filterPredicate.rawValue) %@",        // Wrap up - Challenge 3
                filterKey,
                filterValue
            )
        )
        self.content = content
    }
    
}

struct Challenges: View {
    var body: some View {
        Section(header: Text("Challenges on FilteredList")) {
            
            NavigationLink("Make it accept an array of NSSortDescriptor objects to get used in its fetch request", destination:
                VStack(alignment: .leading) {
                    Text(
                        """
init(filterKey: String,
     filterValue: String,
     sortDescriptors: [NSSortDescriptor],
     @ViewBuilder content: @escaping (T) -> Content
)
"""
                    )
                    .padding()
                    
                    Text("and then when creating the FetchRequest:")
                    
                    Text(
                        """
fetchRequest = FetchRequest<T>(
entity: T.entity(),
sortDescriptors: sortDescriptors,
predicate: NSPredicate(
        format: "%K BEGINSWITH %@",
        filterKey,
        filterValue
    )
)
"""
                    )
                    .padding()
                }
            )
            
            NavigationLink("Make it accept a string parameter that controls which predicate is applied.", destination:
                VStack(alignment: .leading) {
                    Text("Simply adding another argument for the initializer: ")
                    Text(
                        """
init(...,
     filterPredicate: String,
...)
"""
                    )
                    .padding()
                    Text("and then using string interpolation when creating the FetchRequest: ")
                    Text(
                        """
fetchRequest = FetchRequest<T>(
    entity: T.entity(),
    sortDescriptors: sortDescriptors,
    predicate: NSPredicate(
        format: "%K \\(filterPredicate.uppercased()) %@",
        filterKey,
        filterValue
    )
)
"""
                    )
                    .padding()
                }
            )
            
            NavigationLink("Modify the predicate string parameter to be an enum", destination:
                VStack(alignment: .leading) {
                    Text(
                        """
enum Predicate: String {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS"
    ...
}
"""
                    )
                    .padding()
                    
                    Text(
                    """
init(...,
    filterPredicate: Predicate,
    ...
) { /* using filterPredicate.rawValue inside the creation of FetchRequest*/}
"""
                    )
                    .padding()
                    
                    Text(
                        """
ChallengeFilteredList(, filterPredicate: .contains, ) { ... }
"""
                    )
                    .padding()
                    
                    ChallengeFilteredList(filterKey: "name", filterPredicate: .contains, filterValue: "E", sortDescriptors: []) { (ship: Ship) in
                        Text(ship.name ?? "Unknown Name")
                        Spacer()
                        Text("out of").font(.subheadline)
                        Spacer()
                        Text(ship.universe ?? "Unknown Universe")
                    }
                }
            )
            
        }
    }
}

struct Challenges_Previews: PreviewProvider {
    static var previews: some View {
        Challenges()
    }
}
