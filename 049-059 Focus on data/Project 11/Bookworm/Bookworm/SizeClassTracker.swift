//
//  SizeClassTracker.swift
//  Bookworm
//
//  Created by Michael Brünen on 24.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct SizeClassTracker: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            return HStack {
                Text("Active size class:")
                Text("COMPACT")
            }
            .font(.largeTitle)
        } else {
            return HStack {
                Text("Active size class:")
                Text("REGULAR")
            }
            .font(.largeTitle)
        }
    }
}

struct SizeClassTracker_Previews: PreviewProvider {
    static var previews: some View {
        SizeClassTracker()
    }
}
