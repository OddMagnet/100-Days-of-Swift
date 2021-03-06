//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Michael Brünen on 22.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("How layout works in SwiftUI", destination: Layout())
                NavigationLink("Alignment and alignment guides", destination: Alignment())
                NavigationLink("How to create a custom alignment guide", destination: AlignmentGuides())
                NavigationLink("Absolute positioning for SwiftUI views", destination: Absolute())
                NavigationLink("Understanding frames and coordinates inside GeometryReader", destination: FramesCoordinates())
                NavigationLink("ScrollView effects using GeometryReader", destination: ScrollViewEffects())
            }
            .navigationBarTitle("Layout and Geometry")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
