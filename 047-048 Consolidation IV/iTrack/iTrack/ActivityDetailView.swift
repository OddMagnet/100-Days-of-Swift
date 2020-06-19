//
//  ActivityDetailView.swift
//  iTrack
//
//  Created by Michael Brünen on 19.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ActivityDetailView: View {
    @EnvironmentObject var activities: Activities
    var index: Int
    
    var body: some View {
        VStack {
            Text(activities.items[index].name)
            Text(activities.items[index].description)
            Text(activities.items[index].type.rawValue)
            Text("Times completed: \(activities.items[index].timesCompleted)")
            Button("Completed") {
                self.activities.items[self.index].completed()
            }
        }
        .navigationBarTitle("Activity Overview")
    }
}

//struct ActivityDetailView_Previews: PreviewProvider {
//    static var activity = Activity(name: "Test", description: "A useful test activity", timesCompleted: 42)
//    static var previews: some View {
//        ActivityDetailView(activity: activity)
//    }
//}
