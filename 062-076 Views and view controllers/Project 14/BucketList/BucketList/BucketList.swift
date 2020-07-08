//
//  BucketList.swift
//  BucketList
//
//  Created by Michael Brünen on 08.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI
import MapKit

// Wrap up - Challenge 2 - Refactor main UI into it's own view

struct BucketList: View {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    @Binding var showingEditScreen: Bool
    @Binding var locations: [CodableMKPointAnnotation]

    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate,
                    selectedPlace: $selectedPlace,
                    showingPlaceDetails: $showingPlaceDetails,
                    annotations: locations)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        self.locations.append(newLocation)
                        self.selectedPlace = newLocation
                        self.showingEditScreen = true
                    }) {
                        // Wrap up - Challenge 1 - Increase the tapable area of the button
                        // everything in here will be the tapable area, so moving the modifiers in
                        // will increase the tapable are of the '+'
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                    //                        .padding()
                    //                        .background(Color.black.opacity(0.75))
                    //                        .foregroundColor(.white)
                    //                        .font(.title)
                    //                        .clipShape(Circle())
                    //                        .padding(.trailing)
                }
            }
        }
    }
}

struct BucketList_Previews: PreviewProvider {
    static var previews: some View {
        BucketList(centerCoordinate: .constant(MKPointAnnotation.example.coordinate),
                   selectedPlace: .constant(MKPointAnnotation.example),
                   showingPlaceDetails: .constant(false),
                   showingEditScreen: .constant(false),
                   locations: .constant([CodableMKPointAnnotation]()))
    }
}
