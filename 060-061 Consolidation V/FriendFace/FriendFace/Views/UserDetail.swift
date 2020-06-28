//
//  UserDetail.swift
//  FriendFace
//
//  Created by Michael Brünen on 28.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct UserDetail: View {
    var user: User
    
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
            
            Section(header: Text("Friends")) {
                ForEach(user.friends) { friend in
                    Text(friend.name)
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
                                  friends: [
                                    Friend(id: UUID(), name: "Test FriendA"),
                                    Friend(id: UUID(), name: "Test FriendE"),
                                    Friend(id: UUID(), name: "Test FriendI"),
                                    Friend(id: UUID(), name: "Test FriendO"),
                                    Friend(id: UUID(), name: "Test FriendU")
                ]
                )
            )
        }
    }
}
