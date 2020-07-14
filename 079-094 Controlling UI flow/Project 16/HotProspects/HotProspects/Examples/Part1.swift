//
//  Part1.swift
//  HotProspects
//
//  Created by Michael Brünen on 14.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    @Published var name = "Odd Magnet"
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}

struct Part1: View {
    let user = User()
    
    var body: some View {
        Section(header: Text("Part 1")) {
            
            NavigationLink("Reading custom values from the environment with @EnvironmentObject", destination:
                VStack(alignment: .leading) {
                    EditView()
                        .padding()
                        .border(Color.blue)
                    DisplayView()
                        .padding()
                }
                .padding()
                .environmentObject(user)
            )
        }
    }
}

struct Part1_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Part1()
            }
        }
    }
}
