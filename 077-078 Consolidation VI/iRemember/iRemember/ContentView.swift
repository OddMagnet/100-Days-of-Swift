//
//  ContentView.swift
//  iRemember
//
//  Created by Michael Brünen on 12.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddPersonSheet = false
    @State private var newImage: UIImage?
    @State private var newFirstName: String = ""
    @State private var newLastName: String = ""
    
    @State private var people = [Person]()

    var body: some View {
        NavigationView {
            List(people.sorted()) { person in
                NavigationLink(destination: Text("DetailView")) {
                    HStack {
                        Image(uiImage: person.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 50)
                        Text("\(person.firstName) \(person.lastName)")
                            .font(.headline)
                    }
                }
            }
            .navigationBarTitle("iRemember")
            .navigationBarItems(trailing: Button(action: {
                self.showingAddPersonSheet = true
            }){
                Image(systemName: "plus")
                    .padding(5)
            })
        }
        .onAppear(perform: loadData)
        .sheet(isPresented: $showingAddPersonSheet, onDismiss: addPerson) {
            AddPersonView(firstName: self.$newFirstName, lastName: self.$newLastName, image: self.$newImage)
        }
    }
    
    func loadData() {
        // load stuff
    }
    
    func saveData() {
        // save stuff
    }
    
    func addPerson() {
        let newPerson = Person(firstName: newFirstName, lastName: newLastName, image: newImage!)
        people.append(newPerson)
        
        newFirstName = ""
        newLastName = ""
        newImage = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
