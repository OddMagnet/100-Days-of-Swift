//
//  Examples.swift
//  Moonshot
//
//  Created by Michael Brünen on 12.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Examples: View {
    struct User: Codable {
        var name: String
        var address: Address
    }
    struct Address: Codable {
        var street: String
        var city: String
    }
    @State private var user = User(name: "None", address: Address(street: "None", city: "None"))
    let input = """
    {
        "name": "Taylor Swift",
        "address": {
            "street": "555, Taylor Swift Avenue",
            "city": "Nashville"
        }
    }
    """
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Section(header: Text("GeometryReader example").font(.headline)){
                    GeometryReader { geo in
                        Image("Example")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width)
                    }
                }
                
                Section(header: Text("ScrollView example").font(.headline)) {
                    ScrollView(.vertical) {
                        VStack(spacing: 10){
                            ForEach(0..<100) {
                                Text("Item \($0)")
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                
                Section(header: Text("NavigationLink example").font(.headline)) {
                    NavigationLink(destination: Text("Detail View")) {
                        Text("Master View")
                    }
                }
                
                Section(header: Text("Hierachical Codable data example").font(.headline)) {
                    Text(input)
                        .disabled(true)
                    Button("Decode JSON") {
                        let data = Data(self.input.utf8)
                        let decoder = JSONDecoder()
                        if let decoded = try? decoder.decode(User.self, from: data) {
                            self.user = decoded
                        }
                    }
                    
                    Text("Name: \(user.name) \nAddress: \(user.address.street) in \(user.address.city)")
                }
            }
            .navigationBarTitle("Examples")
        }
    }
}

struct Examples_Previews: PreviewProvider {
    static var previews: some View {
        Examples()
    }
}
