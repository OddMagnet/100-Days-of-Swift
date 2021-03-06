//
//  DiceRoll+CoreDataProperties.swift
//  iRoll
//
//  Created by Michael Brünen on 25.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//
//

import Foundation
import CoreData


extension DiceRoll {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiceRoll> {
        return NSFetchRequest<DiceRoll>(entityName: "DiceRoll")
    }

    @NSManaged public var rolls: [Int]?
    @NSManaged public var sides: Int16
    
    var wrappedRolls: [Int] {
        rolls ?? []
    }
    
    var wrappedSides: Int {
        Int(sides)
    }

}
