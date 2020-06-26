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
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Movie.entity(), sortDescriptors: []) var movies: FetchedResults<Movie>
    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    @State private var neededSaving = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Part 1")) {
                    
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
                    
                    NavigationLink("Creating NSManagedObject subclasses", destination:
                        VStack {
                            Button("Create empty movie object") {
                                let _ = Movie(context: self.moc)
                                try? self.moc.save()
                            }
                            
                            List(movies, id: \.self) { movie in
                                HStack {
                                    Text(movie.wrappedTitle)
                                    Spacer()
                                    Text("by")
                                    Spacer()
                                    Text(movie.wrappedDirector)
                                }
                            }
                        }
                    )
                    
                    NavigationLink("Conditional saving of NSManagedObjectContext", destination:
                        VStack {
                            Button("Change something") {
                                let newMovie = Movie(context: self.moc)
                                newMovie.title = "New"
                                newMovie.director = "Old"
                                newMovie.year = 1992
                            }
                            .padding()
                            
                            Button("Save") {
                                if self.moc.hasChanges {
                                    self.neededSaving = true
                                    try? self.moc.save()
                                } else {
                                    self.neededSaving = false
                                }
                            }
                            .padding()
                            
                            Text("Last save actually wrote data?: \(neededSaving ? "Yes" : "No")")
                        }
                    )
                    
                    NavigationLink("Ensuring Core Data objects are unique using constraints", destination:
                        VStack {
                            List(wizards, id: \.self) { wizard in
                                Text(wizard.name ?? "Unknown")
                            }
                            
                            Button("Add") {
                                let wizard = Wizard(context: self.moc)
                                wizard.name = "Harry Potter"
                            }
                            
                            Button("Save") {
                                do {
                                    try self.moc.save()
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    )
                    
                }
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
