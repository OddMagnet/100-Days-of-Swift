//
//  Examples.swift
//  BucketList
//
//  Created by Michael Brünen on 04.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Examples: View {
    var body: some View {
        NavigationView {
            List {
                
                Part1()
                
            }
            .navigationBarTitle("Bucket List Examples")
        }
    }
}

struct Examples_Previews: PreviewProvider {
    static var previews: some View {
        Examples()
    }
}
