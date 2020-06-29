//
//  Friend+CoreDataClass.swift
//  FriendFace
//
//  Created by Michael Brünen on 29.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Friend)
public class Friend: NSManagedObject, Identifiable, Codable {

    enum CodingKeys: CodingKey {
        case id
        case name
    }
    /*
     @NSManaged public var id: UUID
     @NSManaged public var name: String
     @NSManaged public var friendOf: User?
     */
    
    // MARK: - Encodable conformance
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    // MARK: - Decodable conformance
    required convenience public init(from decoder: Decoder) throws {
        // get the context and the entity in the context
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for entity Friend]") }
        guard let entity = NSEntityDescription.entity(forEntityName: "Friend", in: context) else { fatalError("Could not get entity [for entity Friend]") }
        
        // init self
        self.init(entity: entity, insertInto: context)
        
        // create container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // and start decoding
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }

}
