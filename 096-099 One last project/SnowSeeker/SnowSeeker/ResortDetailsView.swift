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
        VStack {
            Text("Size: \(resort.sizeString)")
            Text("Price: \(resort.priceString)")
        }
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}
