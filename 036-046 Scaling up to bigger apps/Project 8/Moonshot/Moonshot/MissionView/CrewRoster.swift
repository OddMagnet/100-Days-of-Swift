//
//  CrewRoster.swift
//  Moonshot
//
//  Created by Michael Brünen on 04.01.22.
//  Copyright © 2022 Michael Brünen. All rights reserved.
//

import Foundation
import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct CrewRoster: View {
    let crew: [CrewMember]

    func getStyleForRole(_ role: String) -> some View {
        let color = role == "Commander" ? Color.yellow : Color.primary
        let lineWidth: CGFloat = role == "Commander" ? 3 : 1

        return Capsule().stroke(color, lineWidth: lineWidth)
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )

                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)

                                Text(crewMember.role)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct CrewRoster_Previews: PreviewProvider {
    static var previews: some View {
        CrewRoster(crew: [])
    }
}
