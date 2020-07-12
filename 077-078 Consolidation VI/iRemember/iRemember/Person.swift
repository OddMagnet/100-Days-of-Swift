//
//  Person.swift
//  iRemember
//
//  Created by Michael Brünen on 12.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Person: Codable, Comparable {
    let firstName: String
    let lastName: String
    let image: UIImage
    
    enum CodingKeys: CodingKey {
        case firstName, lastName, image
    }
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.lastName < rhs.lastName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        let imageData = try container.decode(Data.self, forKey: .image)
        image = UIImage(data: imageData)!
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .firstName)
        let imageData = image.jpegData(compressionQuality: 0.8)
        try container.encode(imageData!, forKey: .image)
    }
}
