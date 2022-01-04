//
//  Order.swift
//  CupcakeCorner
//
//  Created by Michael Brünen on 21.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

class Model: ObservableObject {
    @Published var order = Order()
}

// Wrap up - Challenge 3 - change model from class to struct
struct Order: Codable {
    // enum for de- and encoding support
    /*
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    // conform to encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // no need to catch errors here, function is marked as throwing so errors propagate upwards
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    // conform to decodable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    // empty initializer to create new orders
    init() { }
     */
    
    // Cupcake types
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    // Order Details
    var type = 0
    var quantity = 3
    
    // Extra options
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    // Customer address
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    // Wrap up - Challenge 1 - Improve address validation
    // Address validation
    var hasValidAddress: Bool {

        // check for empty fields
        if name.isReallyEmpty || streetAddress.isReallyEmpty || city.isReallyEmpty || zip.isReallyEmpty {
            return false
        }
        
        // check each field
        if !hasValidStreetAddress || !hasValidCity || !hasValidZip {
            return false
        }

        return true
    }
    
    // Wrap up - Challenge 1 - Improve address validation
    var hasValidStreetAddress: Bool {
        // matches words with whitespaces and special characters with 5+ letters, followed by an optional '.' a space and one or more numbers
        let streetRegex = try! NSRegularExpression(pattern: "[A-zßäöü ]{5,}.*\\d+")
        return streetRegex.firstMatch(in: streetAddress, options: [], range: NSRange(location: 0, length: streetAddress.utf16.count)) != nil
    }
    
    // Wrap up - Challenge 1 - Improve address validation
    var hasValidCity: Bool {
        // matches words with normal and special characters with 4+ letters
        let cityRegex = try! NSRegularExpression(pattern: "[A-zßäöü]{4,}")
        return cityRegex.firstMatch(in: city, options: [], range: NSRange(location: 0, length: city.utf16.count)) != nil
    }
    
    // Wrap up - Challenge 1 - Improve address validation
    var hasValidZip: Bool {
        // matches 5 digits
        let zipRegex = try! NSRegularExpression(pattern: "\\d{5}")
        return zipRegex.firstMatch(in: zip, options: [], range: NSRange(location: 0, length: zip.utf16.count)) != nil
    }
    
    // Pricing
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
