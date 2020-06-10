//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Michael Brünen on 10.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let cost: Int
}
