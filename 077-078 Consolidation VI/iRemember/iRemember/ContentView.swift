//
//  ContentView.swift
//  iRemember
//
//  Created by Michael Brünen on 12.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingImagePicker = false
    @State private var showingAddPersonView = false
    @State private var newImage: UIImage?
    
    var body: some View {
        NavigationView {
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                NavigationLink(destination: Text("DetailView")) {
                    HStack {
                        Image(systemName: "camera")
                        Text("Hello, World!")
                            .font(.headline)
                    }
                }
            }
            .navigationBarTitle("iRemember")
            .navigationBarItems(trailing: Button(action: {
                self.showingImagePicker = true
            }){
                Image(systemName: "plus")
                    .padding(5)
            })
        }
        .onAppear(perform: loadData)
        .sheet(isPresented: $showingImagePicker, onDismiss: addPerson) {
            ImagePicker(image: self.$newImage)
        }
    }
    
    func loadData() {
        // load stuff
    }
    
    func saveData() {
        // save stuff
    }
    
    func addPerson() {
        // only continue if an image was selected
        if let newImage = newImage {
            showingAddPersonView = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
