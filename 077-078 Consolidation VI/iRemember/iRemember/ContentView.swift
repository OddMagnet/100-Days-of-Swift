//
//  ContentView.swift
//  iRemember
//
//  Created by Michael Brünen on 12.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var showingAddPersonSheet = false
    @State private var newImage: UIImage?
    @State private var newFirstName: String = ""
    @State private var newLastName: String = ""
    @State private var newFirstMeetingLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var people = [Person]()

    var body: some View {
        NavigationView {
            List(people.sorted()) { person in
                NavigationLink(destination: PersonDetailView(person: person)) {
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
            AddPersonView(firstName: self.$newFirstName, lastName: self.$newLastName, image: self.$newImage, location: self.$newFirstMeetingLocation)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let fileUrl = getDocumentsDirectory().appendingPathComponent("People")
        
        // if data is available, try loading it
        if let data = try? Data(contentsOf: fileUrl) {
            do {
                people = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                alertTitle = "Loading error"
                alertMessage = "Could not load data"
                self.showingAlert = true
            }
        }
    }
    
    func saveData() {
        do {
            let fileUrl = getDocumentsDirectory().appendingPathComponent("People")
            let data = try JSONEncoder().encode(self.people)
            try data.write(to: fileUrl, options: [.atomicWrite, .completeFileProtection])
        } catch {
            alertTitle = "Saving error"
            alertMessage = "Could not save data"
            self.showingAlert = true
        }
    }
    
    func addPerson() {
        // create and add a new person
        let newPerson = Person(firstName: newFirstName, lastName: newLastName, image: newImage!, location: Coordinate(newFirstMeetingLocation))
        people.append(newPerson)
        
        // reset state variable
        newFirstName = ""
        newLastName = ""
        newImage = nil
        newFirstMeetingLocation = CLLocationCoordinate2D()
        
        // save the data
        saveData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
