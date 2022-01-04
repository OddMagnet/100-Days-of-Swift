//
//  Activity.swift
//  iTrack
//
//  Created by Michael Brünen on 19.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import Foundation

enum ActivityType: String, Codable, Equatable, CaseIterable {
    case sport = "🎽"
    case work = "💼"
    case learning = "🎓"
    case hobby = "✨"

    var name: String {
        switch self {
            case .sport:
                return "Sport"
            case .work:
                return "Work"
            case .learning:
                return "Learning"
            case .hobby:
                return "Hobby"
        }
    }
}

struct Activity: Codable, Identifiable, Equatable {
    var id = UUID()
    var name: String
    var type: ActivityType
    var description: String
    var timesCompleted: Int = 0
    
    static let example = Activity(
        name: "Example activity",
        type: .learning,
        description: "This is a test activity."
    )
}
