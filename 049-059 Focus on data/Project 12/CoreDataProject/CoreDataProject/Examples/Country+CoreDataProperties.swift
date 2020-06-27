//
//  Country+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Michael Brünen on 27.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var shortName: String?
    @NSManaged public var candy: NSSet?

    public var wrappedShortName: String {
        shortName ?? "Unknown country"
    }
    
    public var wrappedFullName: String {
        fullName ?? "Unknown country"
    }
    
    public var candyArray: [Candy] {
        // create a set that's usable by SwiftUI
        let set = candy as? Set<Candy> ?? []
        // sort the set based on the condition in closure
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for candy
extension Country {

    @objc(addCandyObject:)
    @NSManaged public func addToCandy(_ value: Candy)

    @objc(removeCandyObject:)
    @NSManaged public func removeFromCandy(_ value: Candy)

    @objc(addCandy:)
    @NSManaged public func addToCandy(_ values: NSSet)

    @objc(removeCandy:)
    @NSManaged public func removeFromCandy(_ values: NSSet)

}
