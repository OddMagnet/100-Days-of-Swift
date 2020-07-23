//
//  FramesCoordinates.swift
//  LayoutAndGeometry
//
//  Created by Michael Brünen on 23.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .padding(.horizontal)
                .background(Color.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    @State private var gcX: CGFloat = .zero
    @State private var gcY: CGFloat = .zero
    @State private var ccX: CGFloat = .zero
    @State private var ccY: CGFloat = .zero
    @State private var lcX: CGFloat = .zero
    @State private var lcY: CGFloat = .zero

    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                VStack {
                    Text("Center")
                        .background(Color.blue)
                        .onTapGesture {
                            self.gcX = geo.frame(in: .global).midX
                            self.gcY = geo.frame(in: .global).midY
                            self.ccX = geo.frame(in: .named("Custom")).midX
                            self.ccY = geo.frame(in: .named("Custom")).midY
                            self.lcX = geo.frame(in: .local).midX
                            self.lcY = geo.frame(in: .local).midY
                    }
                    Text("Global (red): \(self.gcX, specifier: "%.02f") x \(self.gcY, specifier: "%.02f")")
                    Text("Custom (green): \(self.ccX, specifier: "%.02f") x \(self.ccY, specifier: "%.02f")")
                    Text("Local (orange): \(self.lcX, specifier: "%.02f") x \(self.lcY, specifier: "%.02f")")
                }
            }
            .background(Color.orange)
            Text("Right")
        }
    }
}

struct FramesCoordinates: View {
    var body: some View {
        OuterView()
            .background(Color.red)
            .coordinateSpace(name: "Custom")
    }
}

struct FramesCoordinates_Previews: PreviewProvider {
    static var previews: some View {
        FramesCoordinates()
    }
}
