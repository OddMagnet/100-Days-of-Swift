//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Michael Brünen on 27.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

class Favorites: ObservableObject {
    // set of ids of the resorts the user has favorited
    private var resorts: Set<String>
    
    // key used to save and load the data
    private let saveKey = "Favorites"
    
    init() {
        // load saved data
        
        // if there's no data, use an empty set
        self.resorts = []
    }
    
    // checks if a resort is in the favorites
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    // adds a resort to the favorites, updates views and saves data
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    // removes a resort from the favorites, updates views and saves data
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // write data
    }
}
