//
//  Mission.swift
//  Moonshot
//
//  Created by Michael Brünen on 13.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    private let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            return launchDate.formatted(date: .complete, time: .omitted)
        } else {
            return "N/A"
        }
    }
    
    // Wrap up - Challenge 3 - Add toggle between launch date and crew list in ContentView
    var crewList: String {
        let list = crew.map({ $0.name.capitalized })
        return list.joined(separator: ", ")
    }
}
