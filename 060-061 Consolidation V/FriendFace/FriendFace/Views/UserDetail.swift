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
    var friends: [User]
    
    var body: some View {
        List {
            HStack {
                OnlineIndicator(isActive: user.isActive)
                Text("joined on: \(user.registeredShortDate)")
            }
            .font(.subheadline)
            
            Section(header: Text("General")) {
                detailItem(title: "Age", description: String(user.age))
                detailItem(title: "Address", description: user.address)
                detailItem(title: "Company", description: user.company)
                detailItem(title: "Email", description: user.email)
                detailItem(title: "Interests", description: user.wrappedTags.joined(separator: ", "))
            }
            
            Section(header: Text("About")) {
                Text(user.about)
            }
            
            // only show friends on the first detail view
            // the next one won't be passed a full array of friends
            // this avoids the user hoping into thousands of detail-views
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
                .font(.callout)
                .lineLimit(2)
                .multilineTextAlignment(.trailing)
        }
    }
}

//struct UserDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            UserDetail()
//        }
//    }
//}
