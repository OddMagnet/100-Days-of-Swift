//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Michael Brünen on 21.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                    .foregroundColor(.green)
                TextField("Street Address", text: $order.streetAddress)
                    .foregroundColor(order.hasValidStreetAddress ? .green : .red)
                TextField("City", text: $order.city)
                    .foregroundColor(order.hasValidCity ? .green : .red)
                TextField("Zip", text: $order.zip)
                    .foregroundColor(order.hasValidZip ? .green : .red)
            }
            .disableAutocorrection(true)

            Section {
                NavigationLink("Check out", destination:
                    CheckoutView(order: order)
                )
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
