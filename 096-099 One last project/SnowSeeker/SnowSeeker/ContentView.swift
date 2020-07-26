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
}

struct ContentView: View {
    @State private var selectedUser: User? = nil
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("New Secondary")) {
                Text("Hello, World!")
                    .onTapGesture {
                        self.selectedUser = User()
                }
                .alert(item: $selectedUser) { user in
                    Alert(title: Text(user.id))
                }
            }
            .navigationBarTitle("Primary")
            
            Text("Hello, Secondary")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
