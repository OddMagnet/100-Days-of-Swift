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
    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]
    
    var body: some View {
        NavigationView {
            
            NavigationLink("Why does \\.self work for ForEach", destination:
                VStack {
                    Text("""
When using \\.self as the id in a List or ForEach, Swift uses the hash of the object.
A hash is a unique string calculated based on the content of an object.
This only works with data that conforms to the Hashable protocol.
""")
                    List(students, id: \.self) { student in
                        Text(student.name)
                    }
                }
            )
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
