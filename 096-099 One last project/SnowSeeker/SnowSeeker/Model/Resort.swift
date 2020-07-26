//
//  Resort.swift
//  SnowSeeker
//
//  Created by Michael Brünen on 26.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import Foundation

struct Resort: Codable, Identifiable {
    static private let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
}

/* Example data
 {
     "id": "les-trois-vallees",
     "name": "Les Trois Vallées",
     "country": "France",
     "description": "Les Trois Vallées is a ski region in the Tarentaise Valley, Savoie département of France, to the south of the town of Moûtiers, partly in the Vanoise National Park.\n\nSince 1973, it has been possible to ski the interlinked valleys using a single ski pass. Thus, Les Trois Vallées is the largest ski area in the world which is connected solely by ski lifts and slopes. It claims to have about 600 km (370 mi) of ski slopes, resulting in 18.5 km² of groomed runs, while an independent expert measured about 493 km. In addition, there are 120 km for cross-country skiing. Les Trois Vallées has 183 ski lifts, which can transport 260,000 skiers per hour. Other equipment owned by the operating companies include 2,300 snow cannons and 73 snow grooming machines operated by 160 snow groomers who work in shifts during the night. Other employees in the area include 424 ski patrollers and 3,000 ski instructors.\n\nAs implied by its name, the area originally consisted of three valleys: Saint-Bon, Allues, and Belleville. The skiing area has since been extended into a 'fourth' valley, the Maurienne valley. It is adjacent to Val Thorens, but can also be accessed using a long gondola lift from Orelle.",
     "imageCredit": "Ben Koorengevel",
     "price": 3,
     "size": 3,
     "snowDepth": 155,
     "elevation": 3230,
     "runs": 335,
     "facilities": [
         "Family",
         "Cross-country",
         "Accommodation",
         "Eco-friendly"
     ]
 },
 */
