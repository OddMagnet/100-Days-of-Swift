//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Michael Brünen on 20.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = Model()
    
    var body: some View {
        //        ExamplesView()
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $model.order.type) {
                        ForEach(0 ..< Order.types.count) {
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
