//
//  ContentView.swift
//  Moonshot
//
//  Created by Michael Brünen on 12.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    // Wrap up - Challenge 3 - Add toggle between launch date and crew list in ContentView
    @State private var showCrewInsteadOfLaunchDate = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(missions) { mission in
                    NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            // Wrap up - Challenge 3 - Add toggle between launch date and crew list in ContentView
                            if self.showCrewInsteadOfLaunchDate {
                                Text(mission.crewList)
                            } else {
                                Text(mission.formattedLaunchDate)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            // Wrap up - Challenge 3 - Add toggle between launch date and crew list in ContentView
            .navigationBarItems(trailing: Button(action: {
                self.showCrewInsteadOfLaunchDate.toggle()
            }) {
                Text(showCrewInsteadOfLaunchDate ? "Launch" : "Crew")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
