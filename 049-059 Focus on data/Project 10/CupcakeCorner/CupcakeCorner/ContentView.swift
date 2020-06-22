//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Michael Brünen on 20.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        //        ExamplesView()
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                
                Section {
                    Section {
                        Toggle(isOn: $order.specialRequestEnabled.animation()) {
                            Text("Any special requests?")
                        }
                        
                        if order.specialRequestEnabled {
                            Toggle(isOn: $order.extraFrosting) {
                                Text("Add extra frosting")
                            }
                            
                            Toggle(isOn: $order.addSprinkles) {
                                Text("Add extra sprinkles")
                            }
                        }
                    }
                }
                
                Section {
                    NavigationLink("Delivery details", destination:
                        AddressView(order: order)
                    )
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
