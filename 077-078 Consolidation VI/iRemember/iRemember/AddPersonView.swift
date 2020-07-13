//
//  AddPersonView.swift
//  iRemember
//
//  Created by Michael Brünen on 12.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct AddPersonView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var image: UIImage?
    @State private var showingImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
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
                        HStack {
                            Button("Select photo") {
                                self.sourceType = .photoLibrary
                                self.showingImagePicker = true
                            }
                            .padding()
                            
                            Spacer()
                            
                            Button("Take photo") {
                                self.sourceType = .camera
                                self.showingImagePicker = true
                            }
                            .padding()
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
                self.presentationMode.wrappedValue.dismiss()
            }
            .disabled(!canSave)
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$image, sourceType: self.sourceType)
        }
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(firstName: .constant("Test"), lastName: .constant("Name"), image: .constant(nil))
    }
}
