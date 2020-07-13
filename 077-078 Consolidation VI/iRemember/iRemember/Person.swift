//
//  Person.swift
//  iRemember
//
//  Created by Michael Brünen on 12.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI
import MapKit

struct Person: Codable, Comparable, Identifiable {
    let id: UUID
    let firstName: String
    let lastName: String
    let image: UIImage
    let location: Coordinate
    var CLLocation: CLLocationCoordinate2D {
        CLLocationCoordinate2D(location)
    }
    
    enum CodingKeys: CodingKey {
        case id, firstName, lastName, image, location
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
        location = try container.decode(Coordinate.self, forKey: .location)
    }
    
    init(firstName: String, lastName: String, image: UIImage, location: Coordinate) {
        self.id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
        self.location = location
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        let imageData = image.jpegData(compressionQuality: 0.8)
        try container.encode(imageData!, forKey: .image)
        try container.encode(location, forKey: .location)
    }
}
