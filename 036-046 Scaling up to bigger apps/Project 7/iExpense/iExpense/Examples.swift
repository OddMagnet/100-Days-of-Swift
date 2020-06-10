//
//  Examples.swift
//  iExpense
//
//  Created by Michael Brünen on 10.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

class Album: ObservableObject {
    @Published var bandName = "Metallica"
    @Published var albumName = "Master of Puppets"
}

struct AlbumView: View {
    var album: Album
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            Text("Favorite Album")
                .font(.title)
            Text(album.albumName)
            Text(album.bandName)
            Spacer()
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct User: Codable {
    var firstName: String
    var lastName: String
}

struct Examples: View {
    @ObservedObject var album = Album()
    @State private var showingSheet = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @State private var user = User(firstName: "Odd", lastName: "Magnet")
    @State private var userFromDefaults: String?
    @State private var userSaved = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("ObservableObject example")) {
                    Text("Favorite album: \(album.bandName) - \(album.albumName).")
                    
                    TextField("Band name", text: $album.bandName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Album name", text: $album.albumName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Section(header: Text("Show/Hide view example")) {
                    Button("Show") {
                        self.showingSheet.toggle()
                    }
                }
                Section(header: Text("Deleting items using onDelete() example")) {
                    Button("Add a number") {
                        self.numbers.append(self.currentNumber)
                        self.currentNumber += 1
                    }
                    // List is required to surround the ForEach, in this case the main view of the App is a List
                    // List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)
                    // }
                }
                Section(header: Text("Storing data with UserDefaults example")) {
                    Button("Tap count: \(tapCount)") {
                        self.tapCount += 1
                        UserDefaults.standard.set(self.tapCount, forKey: "Tap")
                    }
                }
                Section(header: Text("Archiving Swift objects with Codable example")) {
                    Text(userFromDefaults ?? "User not loaded")
                    Button("Save User") {
                        let encoder = JSONEncoder()
                        
                        if let data = try? encoder.encode(self.user) {
                            UserDefaults.standard.set(data, forKey: "UserData")
                            self.userSaved = true
                        }
                    }
                    Button("Load User") {
                        let decoder = JSONDecoder()
                        
                        let data = UserDefaults.standard.data(forKey: "UserData")
                        if let decoded = try? decoder.decode(User.self, from: data!) {
                            self.userFromDefaults = decoded.firstName + " " + decoded.lastName
                        }
                    }
                    .disabled(!userSaved)
                }
            }
            .listStyle(GroupedListStyle())
            .sheet(isPresented: $showingSheet) {
                AlbumView(album: self.album)
            }
            .navigationBarTitle("iExpense examples")
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct Examples_Previews: PreviewProvider {
    static var previews: some View {
        Examples()
    }
}
