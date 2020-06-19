//
//  ContentView.swift
//  iTrack
//
//  Created by Michael Brünen on 19.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var activities: Activities = Activities(activities: [Activity]())
    
    var body: some View {
        NavigationView {
            Text("Hello, World!")
        }
    .onAppear(perform: loadData)
    }
    
    func loadData() {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        
        if let data = defaults.data(forKey: "ActivityData") {
            let decodedActivities = try? decoder.decode([Activity].self, from: data)
            activities.activities = decodedActivities ?? [Activity]()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
