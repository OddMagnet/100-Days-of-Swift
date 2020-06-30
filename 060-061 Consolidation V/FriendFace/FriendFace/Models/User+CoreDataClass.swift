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
public class User: NSManagedObject, Identifiable, Decodable {

    enum CodingKeys: CodingKey {
        case id
        case isActive
        case name
        case age
        case company
        case email
        case address
        case about
        case registered
        case tags
        case friends
    }
    
    // MARK: - Encodable conformance
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(id, forKey: .id)
//        try container.encode(isActive, forKey: .isActive)
//        try container.encode(name, forKey: .name)
//        try container.encode(age, forKey: .age)
//        try container.encode(company, forKey: .company)
//        try container.encode(email, forKey: .email)
//        try container.encode(address, forKey: .address)
//        try container.encode(about, forKey: .about)
//        try container.encode(registered, forKey: .registered)
//        try container.encode(tags, forKey: .tags)
//        let friendSet = friends as? Set<Friend> ?? []
//        let friendArray = friendSet.sorted { $0.name < $1.name }
//        try container.encode(friendArray, forKey: .friends)
//    }
    
    // MARK: - Decodable conformance
    required convenience public init(from decoder: Decoder) throws {
        // get the context and the entity in the context
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for entity User]") }
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: context) else { fatalError("Could not get entity [for entity User]") }
        
        // init self
        self.init(entity: entity, insertInto: context)
        
        // create container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // and start decoding
        self.id = try container.decode(UUID.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int16.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(Date.self, forKey: .registered)
        let tagArray = try container.decode([String].self, forKey: .tags)       // decode tags
        self.tags = tagArray.joined(separator: ", ")                            // and join them
        let friendArray = try container.decode([Friend].self, forKey: .friends) // get friends
        self.friends = NSSet(array: friendArray)                                // and convert to NSSet
    }
}
