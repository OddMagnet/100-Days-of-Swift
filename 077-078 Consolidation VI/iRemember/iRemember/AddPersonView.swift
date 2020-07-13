//
//  AddPersonView.swift
//  iRemember
//
//  Created by Michael Brünen on 12.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI
import MapKit

struct AddPersonView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var image: UIImage?
    @Binding var location: CLLocationCoordinate2D
    @State private var showingImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    let locationFetcher = LocationFetcher()
    var canSave: Bool {
        image != nil && !firstName.isEmpty && !lastName.isEmpty
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
                    if image != nil {
                        Image(uiImage: image!)
                            .resizable()
                            .scaledToFit()
                    } else {
                        // using the normal action closure on the buttons result in both activating
                        // this seems to be a bug in SwiftUI, so onTapGesture is used as a work-around
                        HStack {
                            Button(action: {}) {
                                Text("Select photo")
                            }
                            .padding()
                            .onTapGesture {
                                self.sourceType = .photoLibrary
                                self.showingImagePicker = true
                            }
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Text("Take photo")
                            }
                            .padding()
                            .onTapGesture {
                                self.sourceType = .camera
                                self.showingImagePicker = true
                            }
                        }
                    }
                }
                Section(header: Text("Contact info")) {
                    TextField("First name", text: $firstName)
                    TextField("Last name", text: $lastName)
                }
            }
            
            Spacer()
            
            Button("Save") {
                if let location = self.locationFetcher.lastKnownLocation {
                    self.location = location
                }
                self.presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .disabled(!canSave)
        }
        .onAppear(perform: startTracking)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$image, sourceType: self.$sourceType)
        }
    }
    
    func startTracking() {
        self.locationFetcher.start()
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(firstName: .constant("Test"), lastName: .constant("Name"), image: .constant(nil), location: .constant(CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)))
    }
}
