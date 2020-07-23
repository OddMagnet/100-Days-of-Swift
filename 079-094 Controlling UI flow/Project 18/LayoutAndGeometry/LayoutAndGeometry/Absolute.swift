//
//  Absolute.swift
//  LayoutAndGeometry
//
//  Created by Michael Brünen on 23.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Absolute: View {
    var body: some View {
        ZStack {
            Text("Hello, Absolute!")
                .background(Color.yellow)
                .position(x: 100, y: 100)
                .background(Color.red)
            Text("Hello, Relative!")
                .background(Color.yellow)
                .offset(x: 100, y: 100)
                .background(Color.green)
        }
    }
}

struct Absolute_Previews: PreviewProvider {
    static var previews: some View {
        Absolute()
    }
}
