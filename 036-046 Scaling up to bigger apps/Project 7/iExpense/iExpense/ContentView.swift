//
//  ContentView.swift
//  iExpense
//
//  Created by Michael Brünen on 09.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct User: Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    @State private var user = User(firstName: "Odd", lastName: "Magnet")
    
    var body: some View {
        VStack {
            Button("Save User") {
                let encoder = JSONEncoder()
                
                if let data = try? encoder.encode(self.user) {
                    UserDefaults.standard.set(data, forKey: "UserData")
                }
                
                print("Save user")
            }
            Button("Load User") {
                let decoder = JSONDecoder()
                
                let data = UserDefaults.standard.data(forKey: "UserData")
                let decoded = try? decoder.decode(User.self, from: data!)
                
                print(decoded ?? "Was empty")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
