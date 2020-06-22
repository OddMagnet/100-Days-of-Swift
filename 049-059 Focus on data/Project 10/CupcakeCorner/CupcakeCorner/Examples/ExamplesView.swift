//
//  Examples.swift
//  CupcakeCorner
//
//  Created by Michael Brünen on 20.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ExamplesView: View {
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

struct ExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        ExamplesView()
    }
}
