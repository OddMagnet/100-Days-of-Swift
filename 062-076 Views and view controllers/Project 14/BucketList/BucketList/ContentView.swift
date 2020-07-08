//
//  ContentView.swift
//  BucketList
//
//  Created by Michael Brünen on 04.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var locations = [CodableMKPointAnnotation]()
    
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
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .onAppear(perform: loadData)
        .alert(isPresented: $showingPlaceDetails) {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"),
                  message: Text(selectedPlace?.subtitle ?? "Missing place information"),
                  primaryButton: .default(Text("Ok")),
                  secondaryButton: .default(Text("Edit")) {
                    self.showingEditScreen = true
            })
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData){
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let fileUrl = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try Data(contentsOf: fileUrl)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data")
        }
    }
    
    func saveData() {
        do {
            let fileUrl = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: fileUrl, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
