//
//  Part2.swift
//  BucketList
//
//  Created by Michael Brünen on 05.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Part2: View {
    var body: some View {
        
        Section(header: Text("Part 2")) {
            
            NavigationLink("Integrating MapKit with SwiftUI", destination:
                MapView()
                    .edgesIgnoringSafeArea(.all)
            )
            
            NavigationLink("Communicating with a MapKit coordinator", destination:
                MapView()
                    .edgesIgnoringSafeArea(.all)
            )
            
            NavigationLink("Using Touch ID and Face ID with SwiftUI", destination:
                Text("1")
            )
            
        }
    }
}

struct Part2_Previews: PreviewProvider {
    static var previews: some View {
        Part2()
    }
}
