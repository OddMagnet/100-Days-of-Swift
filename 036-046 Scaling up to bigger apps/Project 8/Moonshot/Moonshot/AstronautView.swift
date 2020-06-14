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
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    // Wrap up - Challenge 2 - Show missions the astronaut was part of
                    Text("Missions")
                        .font(.headline)
                    Text(self.getMissionsFor(self.astronaut))
                }
            }
        }
        .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
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
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
