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
    @State private var type = ExpenseType.personal
    @State private var cost = ""
    // Wrap up - Challenge 3 - validate cost field input
    @State private var showingNotIntegerAlert = false
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    
    static let types = [ExpenseType.personal, ExpenseType.business]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                TextField("Cost", text: $cost)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualCost = Double(cost) {
                    let item = ExpenseItem(name: name, type: type, cost: actualCost)
                    expenses.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                } else {
                    showingNotIntegerAlert = true
                }
            })
            // Wrap up - Challenge 3 - validate cost field input
            .alert(isPresented: $showingNotIntegerAlert) {
                Alert(
                    title: Text("Not a number"),
                    message: Text("Only numbers can be entered as the cost"),
                    dismissButton: .cancel(Text("Okay")) {
                        cost = ""
                    }
                )
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
