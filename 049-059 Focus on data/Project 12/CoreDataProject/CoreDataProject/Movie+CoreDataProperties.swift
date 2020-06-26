//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Michael Brünen on 26.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16
    
    // Wrappers to handle data without constant nil-coalescing
    public var wrappedTitle: String {
        title ?? "Unknown title"
    }
    public var wrappedDirector: String {
        director ?? "Unknown director"
    }
    

}
