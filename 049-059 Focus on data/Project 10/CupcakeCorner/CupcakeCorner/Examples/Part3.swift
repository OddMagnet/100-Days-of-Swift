//
//  Part3.swift
//  CupcakeCorner
//
//  Created by Michael Brünen on 22.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Part3: View {
    @ObservedObject var model = Model()
    
    var body: some View {
        Section(header: Text("Part 3")) {
            
            NavigationLink("Encoding an ObservableObject class", destination:
                ScrollView {
                    Text(
                        """
// enum for de- and encoding support
enum CodingKeys: CodingKey {
    case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
}

// conform to encodable
func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    // no need to catch errors here, function is marked as throwing so errors propagate upwards
    try container.encode(type, forKey: .type)
    try container.encode(quantity, forKey: .quantity)
    
    try container.encode(extraFrosting, forKey: .extraFrosting)
    try container.encode(addSprinkles, forKey: .addSprinkles)
    
    try container.encode(name, forKey: .name)
    try container.encode(streetAddress, forKey: .streetAddress)
    try container.encode(city, forKey: .city)
    try container.encode(zip, forKey: .zip)
}

// conform to decodable
required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    type = try container.decode(Int.self, forKey: .type)
    quantity = try container.decode(Int.self, forKey: .quantity)
    
    extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
    addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
    
    name = try container.decode(String.self, forKey: .name)
    streetAddress = try container.decode(String.self, forKey: .streetAddress)
    city = try container.decode(String.self, forKey: .city)
    zip = try container.decode(String.self, forKey: .zip)
}

// empty initializer to create new orders
init() { }
"""
                    )
                }
                .navigationBarTitle("Adding Codable conformance to Order", displayMode: .inline)
            )
            
            NavigationLink("Sending and receiving orders over the internet", destination:
                ScrollView {
                    Text(
                        """
func placeOrder() {
    // Convert current order object into JSON data
    let encoder = JSONEncoder()
    guard let encodedData = try? encoder.encode(order) else {
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
            print("No data in response: \\(error?.localizedDescription ?? "Unknown error").")
            return
        }
        // decode the returned data and display it in an alert
        let decoder = JSONDecoder()
        if let decodedOrder = try? decoder.decode(Order.self, from: data) {
            self.confirmationMessage = "Your order for \\(decodedOrder.quantity)x \\(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            self.showingConfirmation = true
        } else {
            print("Invalid response from server")
        }
        
    }.resume()
}
"""
                    )
                }
                .navigationBarTitle("Handling the server response", displayMode: .inline)
            
            )
            
        }
    }
}


struct Part3_Previews: PreviewProvider {
    static var previews: some View {
        Part3()
    }
}
