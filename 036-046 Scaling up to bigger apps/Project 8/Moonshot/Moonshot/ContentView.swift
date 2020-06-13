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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(missions) { mission in
                    NavigationLink(destination: Text("Detail View")) {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                            Text(mission.launchDate ?? "N/A")
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
