//
//  Examples.swift
//  Drawing
//
//  Created by Michael Brünen on 15.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Examples: View {    
    var body: some View {
        NavigationView {
            List() {
                // Example code is in the files for each day
                Part1()
                
                Part2()

                Part3()
                
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Examples")
        }
    }
}

struct Examples_Previews: PreviewProvider {
    static var previews: some View {
        Examples()
    }
}
