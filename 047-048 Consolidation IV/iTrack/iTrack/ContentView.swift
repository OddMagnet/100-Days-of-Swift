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
                Text("Hello, World!")
            }
            .navigationBarTitle("iTrack")
            .navigationBarItems(trailing:
                Button("Add") {
                    self.showingActivityForm = true
                }
            )
            .sheet(isPresented: $showingActivityForm) {
                AddActivityView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(activities: Activities(activities: loadData()))
    }
}
