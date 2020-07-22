//
//  AlignmentGuides.swift
//  LayoutAndGeometry
//
//  Created by Michael Brünen on 22.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct AlignmentGuides: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@OddMagnetDev")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("FlowerAndBee")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("Full Name:")
                Text("Michael Brünen")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
    }
}

struct AlignmentGuides_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentGuides()
    }
}
