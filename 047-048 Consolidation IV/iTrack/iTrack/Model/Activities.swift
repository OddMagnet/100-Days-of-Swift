//
//  Activities.swift
//  iTrack
//
//  Created by Michael Brünen on 04.01.22.
//  Copyright © 2022 Michael Brünen. All rights reserved.
//

import Foundation

class Activities: ObservableObject {
    @Published var activities: [Activity] {
        // save every time something changes
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }

    init() {
        // try to load from UserDefaults
        if let saved = UserDefaults.standard.data(forKey: "Activities") {
            // on successfull decode, assign the loaded activities to the items array
            if let decoded = try? JSONDecoder().decode([Activity].self, from: saved) {
                activities = decoded
                return
            }
        }

        // create empty activity array if loaded from UserDefaults was not possible
        activities = [Activity]()
    }
}
