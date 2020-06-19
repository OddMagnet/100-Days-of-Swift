//
//  ContentView.swift
//  iTrack
//
//  Created by Michael Brünen on 19.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var activities: Activities
    @State private var showingActivityForm = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(activities.items.indices, id: \.self) { index in
                        NavigationLink(destination: ActivityDetailView(index: index).environmentObject(self.activities)) {
                            HStack {
                                Text(self.activities.items[index].name)
                                    .font(.headline)
                                Spacer()
                                Text("\(self.activities.items[index].timesCompleted) ✅")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("iTrack")
            .navigationBarItems(trailing:
                Button("Add") {
                    self.showingActivityForm = true
                }
            )
            .sheet(isPresented: $showingActivityForm) {
                AddActivityView(activities: self.activities)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(activities: Activities())
    }
}
