//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Michael Brünen on 26.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    @State private var isShowingSortView = false
    @State private var isShowingFilterView = true
    @State private var countryFilter: Resort.CountryTypes = .all
    @State private var sizeFilter: Resort.SizeTypes = .all
    @State private var priceFilter: Resort.PriceTypes = .all
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var filteredResorts: [Resort] {
        var filtered: [Resort] = resorts
        
        if countryFilter != .all {
            filtered = filtered.filter({ $0.country == countryFilter.rawValue})
        }
        
        if sizeFilter != .all {
            filtered = filtered.filter({ $0.size == sizeFilter.rawValue})
        }
        
        if priceFilter != .all {
            filtered = filtered.filter({ $0.price == priceFilter.rawValue})
        }
        
        return filtered
    }
    
    var body: some View {
        NavigationView {
            List {
                if self.isShowingSortView {
                    
                }
                if self.isShowingFilterView {
                    FilterView(countryFilter: $countryFilter,
                               sizeFilter: $sizeFilter,
                               priceFilter: $priceFilter)
                }
                ForEach(filteredResorts) { resort in
                    NavigationLink(destination: ResortView(resort: resort)) {
                        Image(resort.country)
                            .resortImage(width: 40, height: 25, cornerRadius: 5)
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        .layoutPriority(1)
                        
                        if self.favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibility(label: Text("This is a favorite resort"))
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationBarTitle("Resorts")
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
