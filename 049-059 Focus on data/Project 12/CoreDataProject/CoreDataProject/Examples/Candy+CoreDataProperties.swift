//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Michael Brünen on 27.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    public var wrappedName: String {
        name ?? "Unknown candy"
    }

}
