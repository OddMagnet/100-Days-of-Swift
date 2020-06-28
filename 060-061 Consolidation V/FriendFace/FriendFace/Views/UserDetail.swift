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
        VStack(alignment: .leading) {
            
            Text("Age: \(user.age)")
            
            Text("Company: \(user.company)")
        }
        .padding()
        .navigationBarTitle(user.name)
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
