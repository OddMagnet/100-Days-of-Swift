//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Michael Brünen on 28.05.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            Color.white.frame(width: 200, height: 200, alignment: .center)
            VStack {
                HStack {
                    Text("1")
                    Text("2")
                    Text("3")
                }
                .background(Color.red)
                HStack {
                    Text("4")
                    Text("5")
                    Text("6")
                }
                .background(Color.green)
                HStack {
                    Text("7")
                    Text("8")
                    Text("9")
                }
                .background(Color.blue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
