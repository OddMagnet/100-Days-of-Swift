//
//  AddView.swift
//  iExpense
//
//  Created by Michael Brünen on 10.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var cost = ""
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Cost", text: $cost)
                    .keyboardType(.numberPad)
            }
        .navigationBarTitle("Add new expense")
        .navigationBarItems(trailing: Button("Save") {
            if let actualCost = Int(self.cost) {
                let item = ExpenseItem(name: self.name, type: self.type, cost: actualCost)
                self.expenses.items.append(item)
                self.presentationMode.wrappedValue.dismiss()
            }
        })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
