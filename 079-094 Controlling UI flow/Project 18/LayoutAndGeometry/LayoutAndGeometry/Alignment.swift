//
//  Alignment.swift
//  LayoutAndGeometry
//
//  Created by Michael Brünen on 22.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Alignment: View {
    var body: some View {
        VStack {
            Text("Hello, Frame View!")
                .frame(width: 300, height: 300, alignment: .topLeading)
            
            HStack(alignment: .lastTextBaseline) {
                Text("Hello")
                    .font(.caption)
                Text("Frame")
                Text("View")
                    .font(.title)
                Text("!!!")
                    .font(.largeTitle)
            }
            
            VStack(alignment: .leading) {
                Text("Hello, world!")
                    .alignmentGuide(.leading) { d in d[.trailing] }
                Text("This is a longer line of text")
                ForEach(0..<10) { position in
                    Text("Number \(position)")
                        .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
                }ç
            }
            .background(Color.red)
            .frame(width: 400, height: 400)
            .background(Color.blue)
        }
    }
}

struct Alignment_Previews: PreviewProvider {
    static var previews: some View {
        Alignment()
    }
}
