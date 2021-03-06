//
//  MissionView.swift
//  Moonshot
//
//  Created by Michael Brünen on 13.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    let mission: Mission
    let astronaus: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        // match astronauts to missions
        var matches = [CrewMember]()
        // for every member of a mission
        for member in mission.crew {
            // check all astronauts for a matching id
            if let match = astronauts.first(where: { $0.id == member.name}) {
                // then add the astronaut to the matches
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                // if no astronaut is found the json file must be corrupted
                fatalError("Missing crew member in astronauts.json")
            }
        }
        // finally, assign all matches to the astronauts array for display in the UI
        self.astronaus = matches
    }
    
    func getStyleForRole(_ role: String) -> some View {
        let color = role == "Commander" ? Color.yellow : Color.primary
        let lineWidth: CGFloat = role == "Commander" ? 3 : 1
        
        return Capsule().stroke(color, lineWidth: lineWidth)
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { imgGeo in
                        VStack(alignment: .center) {
                            Image(self.mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: imgGeo.size.width)
                                .padding(.vertical)
                        }
                            // Day 94 - Challenge 1 - Add a scaling effect to the mission badge
                            .scaleEffect(imgGeo.frame(in: .global).maxY / imgGeo.size.height)
                    }
                    
                    // Wrap up - Challenge 1 - Add launch date
                    Text("Launch: \(self.mission.formattedLaunchDate)")
                        .font(.headline)
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronaus, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(self.getStyleForRole(crewMember.role))
                                
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    
                                    Text(crewMember.role)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            .accessibilityElement(children: .ignore)
                            .accessibility(label: Text("\(crewMember.astronaut.name), role: \(crewMember.role)"))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
