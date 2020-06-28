//
//  UserDetail.swift
//  FriendFace
//
//  Created by Michael Brünen on 28.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI
/*
struct UserDetail: View {
    var user: User
    var friends: [User]
    
    var body: some View {
        List {
            Text("since: \(user.registeredShortDate), currently \(user.isActive ? "online" : "offline")")
                .font(.subheadline)
                .foregroundColor(user.isActive ? .green : .primary)
            
            Section(header: Text("General")) {
                detailItem(title: "Age", description: String(user.age))
                detailItem(title: "Address", description: user.address)
                detailItem(title: "Company", description: user.company)
                detailItem(title: "Email", description: user.email)
                detailItem(title: "Interests", description: user.tags.joined(separator: ", "))
            }
            
            Section(header: Text("About")) {
                Text(user.about)
            }
            
            // only show friends on the first detail view
            // the next one won't be passed a full array of friends
            // this avoids the user hoping into thousands of detail-view
            // and not being able to go back to the main content view
            if friends.count > 0 {
                Section(header: Text("Friends")) {
                    ForEach(friends) { friend in
                        NavigationLink(destination: UserDetail(user: friend, friends: [])) {
                            HStack {
                                Text("\(friend.name) (\(friend.age))")
                                Spacer()
                                Text(friend.company)
                            }
                            .foregroundColor(friend.isActive ? .green : .primary)
                        }
                    }
                }
            }
            
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(user.name)
    }
    
    private func detailItem(title: String, description: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text(description)
        }
    }
}

struct UserDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDetail(user: User(id: UUID(),
                                  isActive: true,
                                  name: "Test User",
                                  age: 22,
                                  company: "None",
                                  email: "test@test.test",
                                  address: "Testing Street 123, TestCity",
                                  about: "Lorem ipsum repeatum. Lorem ipsum repeatum. Lorem ipsum repeatum. Lorem ipsum repeatum. Lorem ipsum repeatum. Lorem ipsum repeatum. Lorem ipsum repeatum. Lorem ipsum repeatum. Lorem ipsum repeatum. Lorem ipsum repeatum. Lorem ipsum repeatum. Lorem ipsum repeatum. Lorem ipsum repeatum. Lorem ipsum repeatum. ",
                                  registered: Date(),
                                  tags: ["Test", "estT", "stTe", "tTes", "Test"],
                                  friends: []
                ),
                       friends: [
                        User(id: UUID(), isActive: true, name: "ABC", age: 12, company: "", email: "1", address: "", about: "", registered: Date(), tags: [], friends: []),
                        User(id: UUID(), isActive: false, name: "DEF", age: 23, company: "", email: "2", address: "", about: "", registered: Date(), tags: [], friends: []),
                        User(id: UUID(), isActive: true, name: "GHI", age: 34, company: "", email: "3", address: "", about: "", registered: Date(), tags: [], friends: [])
                        
                ]
            )
        }
    }
}

*/
