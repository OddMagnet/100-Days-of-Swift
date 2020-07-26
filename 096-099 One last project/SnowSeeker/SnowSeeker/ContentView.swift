//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Michael Brünen on 26.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct User: Identifiable {
    var id = "OddMagnet"
    var name = "Michael Brünen"
    var country = "Germany"
    var pets = ["Motty, Muckel"]
}

struct UserView: View {
    var user: User
    
    var body: some View {
        Group {
            Text("Name: \(user.name)")
            Text("Country: \(user.country)")
            Text("Pets: \(user.pets.joined(separator: ", "))")
        }
    }
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack {
                    UserView(user: User())
                }
            } else {
                HStack {
                    UserView(user: User())
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
