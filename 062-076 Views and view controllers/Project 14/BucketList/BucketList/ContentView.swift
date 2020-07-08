//
//  ContentView.swift
//  BucketList
//
//  Created by Michael Brünen on 04.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var isUnlocked = false
    @State private var errorTitle = ""
    @State private var errorMsg = ""
    @State private var showingErrorMessage = false
    
    var body: some View {
        ZStack {
            if isUnlocked {
                // Wrap up - Challenge 2 - Refactor main UI into it's own view
                BucketList(centerCoordinate: $centerCoordinate,
                           selectedPlace: $selectedPlace,
                           showingPlaceDetails: $showingPlaceDetails,
                           showingEditScreen: $showingEditScreen,
                           locations: $locations)
                // Wrap up - Challenge 3 - Show errors when authentication fails
                // refactor place details alert since a view can only have one alert modifier
                .alert(isPresented: $showingPlaceDetails) {
                    Alert(title: Text(selectedPlace?.title ?? "Unknown"),
                          message: Text(selectedPlace?.subtitle ?? "Missing place information"),
                          primaryButton: .default(Text("Ok")),
                          secondaryButton: .default(Text("Edit")) {
                            self.showingEditScreen = true
                    })
                }
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                // Wrap up - Challenge 3 - Show errors when authentication fails
                .alert(isPresented: $showingErrorMessage) {
                    Alert(title: Text(errorTitle), message: Text(errorMsg), dismissButton: .default(Text("Ok")))
                }
            }
        }
        .onAppear(perform: loadData)
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
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "Please authenticate yourself to unlock your places"
            ){ success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // Wrap up - Challenge 3 - Show errors when authentication fails
                        self.errorTitle = "Authentication Error"
                        self.errorMsg = "Authentication failed. Please try again"
                        self.showingErrorMessage = true
                    }
                }
            }
        } else {
            // Wrap up - Challenge 3 - Show errors when authentication fails
            errorTitle = "Device Error"
            errorMsg = "This device does not support biometric authentication"
            showingErrorMessage = true
        }
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
