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
            List {
                ForEach(activities.items.indices, id: \.self) { index in
                    NavigationLink(destination: ActivityDetailView(activities: self.activities, index: index)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(self.activities.items[index].name)
                                    .font(.headline)
                                Text(self.activities.items[index].type.rawValue)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text("Completed \(self.activities.items[index].timesCompleted) times")
                        }
                    }
                }
                .onDelete(perform: removeActivity)
            }
            .navigationBarTitle("iTrack")
            .navigationBarItems(leading: EditButton(), trailing:
                Button("Add") {
                    self.showingActivityForm = true
                }
            )
                .sheet(isPresented: $showingActivityForm) {
                    AddActivityView(activities: self.activities)
            }
        }
    }
    
    func removeActivity(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(activities: Activities())
    }
}
