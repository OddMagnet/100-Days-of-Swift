//
//  Part3.swift
//  HotProspects
//
//  Created by Michael Brünen on 14.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Part3: View {
    @State private var backgroundColor = Color.red
    var body: some View {
        Section(header: Text("Part 3")) {
            
            NavigationLink("Creating context menus", destination:
                VStack {
                    Text("Long press me")
                        .padding()
                        .background(backgroundColor)
                        .contextMenu {
                            Button(action: {
                                self.backgroundColor = .red
                            }) {
                                Text("Red")
                                Image(systemName: backgroundColor == Color.red ? "checkmark.circle.fill" : "circle")
                            }
                            Button(action: {
                                self.backgroundColor = .green
                            }) {
                                Text("Green")
                                Image(systemName: backgroundColor == Color.green ? "checkmark.circle.fill" : "circle")
                            }
                            Button(action: {
                                self.backgroundColor = .blue
                            }) {
                                Text("Blue")
                                Image(systemName: backgroundColor == Color.blue ? "checkmark.circle.fill" : "circle")
                            }
                    }
                }
            )
        }
    }
}

struct Part3_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Part3()
            }
        }
    }
}
