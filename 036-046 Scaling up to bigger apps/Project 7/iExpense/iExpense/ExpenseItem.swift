//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Michael Brünen on 10.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import Foundation

enum ExpenseType: String, Codable {
    case business = "Business"
    case personal = "Personal"
}

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let cost: Double
}
