//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Michael Brünen on 21.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var model: Model
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    // Accessibility challenge 1 - mark image decorative
                    Image(decorative: "cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text("Your total is $\(self.model.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text(confirmationTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        // Convert current order object into JSON data
        let encoder = JSONEncoder()
        guard let encodedData = try? encoder.encode(model.order) else {
            print("Failed to encode order data")
            return
        }
        
        // Prepare a URLRequest to send encoded data as JSON
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        // Configure the request
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedData
        
        // Run the request and process the response
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle the response
            // ensure data was returned
            guard let data = data else {
                // Wrap up - Challenge 2 - Improve error message
                self.confirmationTitle = "Error!"
                self.confirmationMessage = "The server could not be reached. Please check your connection."
                self.showingConfirmation = true
                return
            }
            // decode the returned data and display it in an alert
            let decoder = JSONDecoder()
            if let decodedOrder = try? decoder.decode(Order.self, from: data) {
                self.confirmationTitle = "Thank you!"
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
            
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(model: Model(order: Order()))
    }
}
