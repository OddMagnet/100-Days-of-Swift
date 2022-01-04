//
//  AstronautView.swift
//  Moonshot
//
//  Created by Michael Brünen on 14.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()

                Text(astronaut.description)
                    .padding()

                Text("Missions")
                    .font(.headline)
                Text(self.getMissionsFor(self.astronaut))
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    // Wrap up - Challenge 2 - Show missions the astronaut was part of
    func getMissionsFor(_ astronaut: Astronaut) -> String {
        var missionList = [String]()
        
        for mission in missions {
            if mission.crew.contains(where: { $0.name == astronaut.id} ) {
                missionList.append(mission.displayName)
            }
        }
                
        return missionList.joined(separator: ", ")
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts["aldrin"]!)
            .preferredColorScheme(.dark)
    }
}
