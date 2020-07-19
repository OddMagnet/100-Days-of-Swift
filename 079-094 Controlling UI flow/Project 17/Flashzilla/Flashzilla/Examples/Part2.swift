//
//  Part2.swift
//  Flashzilla
//
//  Created by Michael Brünen on 18.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Part2: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timerCount = ""
    
    var body: some View {
        Section(header: Text("Part 2")) {
            
            NavigationLink("Triggering events repeatedly using a timer", destination:
                VStack {
                    Button("Stop timer") {
                        self.timer.upstream.connect().cancel()
                    }
                    Text(timerCount)
                        .onReceive(timer) { time in
                            self.timerCount = "\(time)"
                    }
                }
            )

            NavigationLink("Placeholder 2", destination:
                Text("Placeholder 2")
            )

            NavigationLink("Placeholder 3", destination:
                Text("Placeholder 3")
            )
        }
    }
}

struct Part2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Part2()
            }
            .navigationBarTitle("Examples")
        }
    }
}
