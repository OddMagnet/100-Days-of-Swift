//
//  ActivityDetailView.swift
//  iTrack
//
//  Created by Michael Brünen on 19.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ActivityDetailView: View {
    @ObservedObject var data: Activities
    var activity: Activity
    
    var body: some View {
        List {
            Section {
                if activity.description.isEmpty == false {
                    Text(activity.description)
                }
            }

            Section {
                Text("Completions: \(activity.timesCompleted)")

                Button("Mark Completed") {
                    var newActivity = activity
                    newActivity.timesCompleted += 1

                    if let index = data.activities.firstIndex(of: activity) {
                        data.activities[index] = newActivity
                    }
                }
            }
        }
        .navigationTitle("\(activity.type.rawValue) \(activity.name)")
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(data: Activities(), activity: Activity.example)
    }
}
