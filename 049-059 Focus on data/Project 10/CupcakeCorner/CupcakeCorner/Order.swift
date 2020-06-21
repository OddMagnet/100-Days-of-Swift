//
//  Order.swift
//  CupcakeCorner
//
//  Created by Michael Brünen on 21.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

class Order: ObservableObject {
    // Cupcake types
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    // Order Details
    @Published var type = 0
    @Published var quantity = 3
    
    // Extra options
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
}
