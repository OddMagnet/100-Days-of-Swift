//
//  ContentView.swift
//  iRemember
//
//  Created by Michael Brünen on 12.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
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
                self.addPerson()
            }){
                Image(systemName: "plus")
            })
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        // load stuff
    }
    
    func saveData() {
        // save stuff
    }
    
    func addPerson() {
        // add new person
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
