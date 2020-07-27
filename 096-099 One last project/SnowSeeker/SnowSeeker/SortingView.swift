//
//  SortingView.swift
//  SnowSeeker
//
//  Created by Michael Brünen on 27.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct SortingView: View {
    @Binding var sortBy: Resort.SortingOptions
    
    var body: some View {
        VStack {
            Text("Sort by")
                .font(.headline)
            Picker("Sort by", selection: $sortBy) {
                ForEach(Resort.SortingOptions.allCases, id: \.self) { option in
                    Text(option.rawValue)
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct SortingView_Previews: PreviewProvider {
    static var previews: some View {
        SortingView(sortBy: .constant(.standard))
    }
}
