//
//  ExpenseSection.swift
//  iExpense
//
//  Created by Michael Brünen on 04.01.22.
//  Copyright © 2022 Michael Brünen. All rights reserved.
//

import Foundation
import SwiftUI

struct ExpenseSection: View {
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void

    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type.rawValue)
                    }

                    Spacer()

                    Text(item.cost, format: .localCurrency)
                        .style(for: item)
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
}
