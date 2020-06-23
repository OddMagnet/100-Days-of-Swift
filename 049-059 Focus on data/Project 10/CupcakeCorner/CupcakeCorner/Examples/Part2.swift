//
//  Part2.swift
//  CupcakeCorner
//
//  Created by Michael Brünen on 21.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Part2: View {
    @ObservedObject var model = Model(order: Order())
    
    var body: some View {
        Section(header: Text("Part 2")) {
            
            NavigationLink("Taking basic order details", destination:
                Form {
                    Section {
                        Picker("Select your cake type", selection: $model.order.type) {
                            ForEach(0..<Order.types.count) {
                                Text(Order.types[$0])
                            }
                        }

                        Stepper(value: $model.order.quantity, in: 3...20) {
                            Text("Number of cakes: \(model.order.quantity)")
                        }
                    }
                    
                    Section {
                        Section {
                            Toggle(isOn: $model.order.specialRequestEnabled.animation()) {
                                Text("Any special requests?")
                            }

                            if model.order.specialRequestEnabled {
                                Toggle(isOn: $model.order.extraFrosting) {
                                    Text("Add extra frosting")
                                }

                                Toggle(isOn: $model.order.addSprinkles) {
                                    Text("Add extra sprinkles")
                                }
                            }
                        }
                    }
                    
                    Section {
                        NavigationLink("Delivery details", destination:
                            AddressView(model: model)
                        )
                    }
                }
                .navigationBarTitle("Cupcake Corner")
            )
            
            NavigationLink("Checking for a valid address", destination:
                AddressView(model: model)
            )

            NavigationLink("Preparing for checkout", destination:
                CheckoutView(model: model)
            )
            
        }
    }
}

struct Part2_Previews: PreviewProvider {
    static var previews: some View {
        Part2()
    }
}
