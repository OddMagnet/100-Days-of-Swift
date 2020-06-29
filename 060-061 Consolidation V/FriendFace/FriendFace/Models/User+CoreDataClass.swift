//
//  User+CoreDataClass.swift
//  FriendFace
//
//  Created by Michael Brünen on 29.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Identifiable, Codable {

    enum CodingKeys: CodingKey {
        case id
        case isActive
        case name
        //    @NSManaged public var age: Int16
        //    @NSManaged public var company: String
        //    @NSManaged public var email: String
        //    @NSManaged public var address: String
        //    @NSManaged public var about: String
        //    @NSManaged public var registered: Date
        //    @NSManaged public var tags: String
        //    @NSManaged public var friends: NSSet
    }
    
    // MARK: - Encodable conformance
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(name, forKey: .name)
    }
    
    // MARK: - Decodable conformance
    required convenience public init(from decoder: Decoder) throws {
        // get the context and the entity in the context
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context") }
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: context) else { fatalError("Could not get entity") }
        
        // init self
        self.init(entity: entity, insertInto: context)
        
        // create container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // and start decoding
        self.id = try container.decode(UUID.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        
    }
}
