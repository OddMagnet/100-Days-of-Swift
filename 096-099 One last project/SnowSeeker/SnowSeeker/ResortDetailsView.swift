//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by Michael Brünen on 26.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort
    
    var body: some View {
        Group {
            Text("Size: \(resort.sizeString)").layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Price: \(resort.priceString)").layoutPriority(1)
        }
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}
