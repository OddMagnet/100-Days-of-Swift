//
//  Activity.swift
//  iTrack
//
//  Created by Michael Brünen on 19.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import Foundation

enum ActivityType: String, Codable, Equatable, CaseIterable {
    case sport = "🎽 Sport"
    case work = "💼 Work"
    case learning = "🎓 Learning"
    case hobby = "✨ Hobby"
}

struct Activity: Codable, Identifiable {
    
    var id = UUID()
    var name: String
    var type: ActivityType
    var description: String
    var timesCompleted: Int = 0
    
    mutating func completed() {
        timesCompleted += 1
    }
}

class Activities: ObservableObject {
    @Published var items: [Activity] {
        // save every time something changes
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(self.items) {
                UserDefaults.standard.set(data, forKey: "ActivityData")
            }
        }
    }
    
    init() {
        // create empty activity array
        items = [Activity]()

        let decoder = JSONDecoder()
        
        // try to load from UserDefaults
        if let data = UserDefaults.standard.data(forKey: "ActivityData") {
            // on successfull decode, assign the loaded activities to the items array
            if let decodedActivities = try? decoder.decode([Activity].self, from: data) {
                items = decodedActivities
            }
        }
    }
}
