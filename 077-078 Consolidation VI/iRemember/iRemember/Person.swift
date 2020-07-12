//
//  Person.swift
//  iRemember
//
//  Created by Michael Brünen on 12.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Person: Codable, Comparable, Identifiable {
    let id: UUID
    let firstName: String
    let lastName: String
    let image: UIImage
    
    enum CodingKeys: CodingKey {
        case id, firstName, lastName, image
    }
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.lastName < rhs.lastName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        let imageData = try container.decode(Data.self, forKey: .image)
        image = UIImage(data: imageData)!
    }
    
    init(firstName: String, lastName: String, image: UIImage) {
        self.id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        let imageData = image.jpegData(compressionQuality: 0.8)
        try container.encode(imageData!, forKey: .image)
    }
}
