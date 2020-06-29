//
//  ContentView.swift
//  FriendFace
//
//  Created by Michael Brünen on 28.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // Core Data context
    @Environment(\.managedObjectContext) var moc
//    @State private var users = [User]()
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [
            //NSSortDescriptor(key: "name", ascending: true)
        ]
    ) var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(destination:
                    UserDetail(user: user, friends: self.getFriendsFor(user))
                ) {
                    Text("\(user.name) (\(user.age))")
                        .foregroundColor(user.isActive ? .green : .primary)
                }
            }
            .navigationBarTitle("FriendFace")
            .onAppear(perform: loadData)
        }
    }
    
    func loadData() {
        // only load date the first time
        if users.isEmpty {
            print("LOADING...!")
            // prepare the request for data
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                fatalError("Failed to create data url")
            }
            let request = URLRequest(url: url)
            
            // request the data
            URLSession.shared.dataTask(with: request) { data, response, error in
                // check if data is present
                if let data = data {
                    // if so, handle it
                    let decoder = JSONDecoder()
                    // add context to the decoder
                    decoder.userInfo[CodingUserInfoKey.context!] = self.moc
                    decoder.dateDecodingStrategy = .iso8601
                    
                    // decode it, the result is not needed since a FetchRequest will be used
                    _ = try? decoder.decode([User].self, from: data)
                    // save the context
                    // COMMENT THIS BACK IN!
                    //try? self.moc.save()
                    return
                }
                // if we're still here it means there was a problem
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }.resume()
        }
    }
    
    func getFriendsFor(_ user: User) -> [User] {
        // create array for the results
        var friends = [User]()

        // add all friends to the result array
        for friend in user.wrappedFriends {
            if let user = users.first(where: { $0.id == friend.id }) {
                friends.append(user)
            }
        }

        return friends
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
