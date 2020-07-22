//
//  Layout.swift
//  LayoutAndGeometry
//
//  Created by Michael Brünen on 22.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct Layout: View {
    var body: some View {
        VStack {
            /*
             3 Steps SwiftUI takes to make it's layout happen
             ================================================
             1) A parent view proposes a size for its child.
             2) Based on that information, the child then chooses its own size and the parent must respect that choice.
             3) The parent then positions the child in its coordinate space.
             (4) Round off any pixels to their nearest value so graphics remain sharp
             */
            Text("Hello, Background!")
                .background(Color.red)
            /*
             For this layout the view hierachy is: SwiftUI > ContentView > Background > Text
             This is because applying a modifier creates a Modified view which stores the original view and it's modifier
             and SwiftUI resolves modified Views from bottom to top
             1) The parent proposes a size for its child
                1) SwiftUI tells ContentView it has the whole screen
                2) ContentView is layout neutral, so it tells Background it has the whole screen
                3) Background is layout neutral too, so it tells Text it has the whole screen
             2) The child chooses its size
                1) Text tells Background the exact amount of pixels it needs
                2) Background then takes the same amount of pixels and tells ContentView it needs exactly those
                3) ContentView also takes the same amount and tells it to SwiftUI
             3) Finally the parent - SwiftUI - positions the view, in this case right in the center
             */
            
            Text("Hello Padding")
                .padding(20)
                .background(Color.green)
            /*
             Again, following the same steps:
             1) The parent proposes a size for its child
                1) SwiftUI tells ContentView it has the whole screen
                2) ContentView is layout neutral, so it tells Background it has the whole screen
                3) Background is layout neutral too, so it tells Padding it has the whole screen
                4) Paddings tells Text it can have the whole screen, minus 20 pixels on each side
             2) The child chooses its size
                1) Text tells Padding the exact amount of pixels it needs
                2) Padding tells Background the same amount + 20 pixels on each side
                3) Background then takes that amount and tells ContentView it needs exactly those
                4) ContentView also takes that amount and tells it to SwiftUI
             3) The parent positions the view, again, centering it
             */
            
            /*
             Some important notes:
             - modifier order matters. A lot.
             - Layout neutral views always take the space that their children need
             - a completely neutral hierachy will take up all available space
             */
        }
    }
}

struct Layout_Previews: PreviewProvider {
    static var previews: some View {
        Layout()
    }
}
