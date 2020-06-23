//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Michael Brünen on 21.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var model: Model
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $model.order.name)
                    .foregroundColor(.green)
                TextField("Street Address", text: $model.order.streetAddress)
                    .foregroundColor(model.order.hasValidStreetAddress ? .green : .red)
                TextField("City", text: $model.order.city)
                    .foregroundColor(model.order.hasValidCity ? .green : .red)
                TextField("Zip", text: $model.order.zip)
                    .foregroundColor(model.order.hasValidZip ? .green : .red)
            }
            .disableAutocorrection(true)

            Section {
                NavigationLink("Check out", destination:
                    CheckoutView(model: model)
                )
            }
            .disabled(model.order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(model: Model(order: Order()))
    }
}
