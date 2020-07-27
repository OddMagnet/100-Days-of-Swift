//
//  FilterView.swift
//  SnowSeeker
//
//  Created by Michael Brünen on 27.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    @Binding var countryFilter: Resort.CountryTypes
    @Binding var sizeFilter: Resort.SizeTypes
    @Binding var priceFilter: Resort.PriceTypes
    
    var body: some View {
        VStack {
            Text("Filter by")
                .font(.headline)
            Picker("Country", selection: $countryFilter) {
                ForEach(Resort.CountryTypes.allCases, id: \.self) { country in
                    Image(country.rawValue)
                }
            }
            
            Picker("Size", selection: $sizeFilter) {
                ForEach(Resort.SizeTypes.allCases, id: \.self) { size in
                    Text(Resort.stringForSize(size.rawValue))
                }
            }
            
            Picker("Price", selection: $priceFilter) {
                ForEach(Resort.PriceTypes.allCases, id: \.self) { price in
                    Text(Resort.stringForPrice(price.rawValue))
                }
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}


struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            FilterView(countryFilter: .constant(.all),
                       sizeFilter: .constant(.all),
                       priceFilter: .constant(.all))
        }
    }
}
