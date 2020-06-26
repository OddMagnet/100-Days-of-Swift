//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Michael Brünen on 26.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            List {
                Part1()
            }
            .navigationBarTitle("CoreDataProject")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
