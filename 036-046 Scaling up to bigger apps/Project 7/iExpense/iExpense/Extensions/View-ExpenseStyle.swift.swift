//
//  View-ExpenseStyle.swift.swift
//  iExpense
//
//  Created by Michael Brünen on 04.01.22.
//  Copyright © 2022 Michael Brünen. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    // Wrap up - Challenge 2 - Style the expense cost
    func style(for item: ExpenseItem) -> some View {
        switch item.cost {
            case 0 ..< 10:
                return self.font(.body).foregroundColor(.green)
            case 10 ..< 100:
                return self.font(.title3).foregroundColor(.orange)
            default:
                return self.font(.title).foregroundColor(.red)
        }
    }

}
