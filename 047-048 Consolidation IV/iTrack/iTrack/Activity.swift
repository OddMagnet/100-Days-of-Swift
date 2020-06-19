//
//  Activity.swift
//  iTrack
//
//  Created by Michael Brünen on 19.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import Foundation

struct Activity: Codable, Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var timesCompleted: Int
}

class Activities: ObservableObject {
    @Published var activities: [Activity]
    
    init(activities: [Activity]) {
        self.activities = activities
    }
}

func loadData() -> [Activity]{
    let defaults = UserDefaults.standard
    let decoder = JSONDecoder()
    
    if let data = defaults.data(forKey: "ActivityData") {
        let decodedActivities = try? decoder.decode([Activity].self, from: data)
        return decodedActivities ?? [Activity]()
    } else {
        return [Activity]()
    }
}
