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
