//
//  Part1.swift
//  BucketList
//
//  Created by Michael Brünen on 04.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct User: Codable, Comparable, Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct Part1: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
        ].sorted()
    @State private var loadedUsers = [User]()
    enum LoadingState {
        case loading, success, failed
    }
    @State private var loadingState: LoadingState = .loading
    
    struct LoadingView: View {
        var body: some View {
            ZStack {
                Color.yellow
                Text("Loading")
            }
        }
    }
    struct SuccessView: View {
        var body: some View {
            ZStack {
                Color.green
                Text("Success")
            }
        }
    }
    struct FailedView: View {
        var body: some View {
            ZStack {
                Color.red
                Text("Failed")
            }
        }
    }
    
    var body: some View {
        Section(header: Text("Part 1")) {
            
            NavigationLink("Adding conformance to Comparable for custom types", destination:
                List(users) { user in
                    Text(user.firstName + " " + user.lastName)
                }
            )
            
            NavigationLink("Writing data to the documents directory", destination:
                VStack {
                    Button("Save users / Clear loaded users") {
                        let documentsUrl = self.getDocumentsDirectory().appendingPathComponent("users.json")
                        
                        let encoder = JSONEncoder()
                        if let encodedUsers = try? encoder.encode(self.users) {
                            do {
                                try encodedUsers.write(to: documentsUrl)
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                        
                        self.loadedUsers = [User]()
                    }
                    Button("Load users") {
                        let documentsUrl = self.getDocumentsDirectory().appendingPathComponent("users.json")
                        
                        let decoder = JSONDecoder()
                        do {
                            let data = try Data(contentsOf: documentsUrl)
                            if let decodedUsers = try? decoder.decode([User].self, from: data) {
                                self.loadedUsers = decodedUsers
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    List(loadedUsers) { user in
                        Text(user.firstName + " " + user.lastName)
                    }
                }
            )

            NavigationLink("Switching view states with enums", destination:
                VStack {
                    if loadingState == .loading {
                        LoadingView()
                    } else if loadingState == .success {
                        SuccessView()
                    } else if loadingState == .failed {
                        FailedView()
                    }
                    HStack(spacing: 20) {
                        Button("Loading") { self.loadingState = .loading }
                        Button("Success") { self.loadingState = .success }
                        Button("Failed") { self.loadingState = .failed }
                    }
                }
            )

        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

struct Part1_Previews: PreviewProvider {
    static var previews: some View {
        Part1()
    }
}
