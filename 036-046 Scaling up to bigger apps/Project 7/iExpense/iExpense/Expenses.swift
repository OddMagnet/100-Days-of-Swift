//
//  Expenses.swift
//  iExpense
//
//  Created by Michael Brünen on 10.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
