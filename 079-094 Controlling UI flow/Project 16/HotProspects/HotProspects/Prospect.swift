//
//  Prospect.swift
//  HotProspects
//
//  Created by Michael Brünen on 17.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    static let saveKey = "SavedProspects"
    // Wrap up - Challenge 2 - save data to documents directory
    private static var documentsUrl: URL {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        url.appendPathComponent(Self.saveKey)
        return url
    }
    @Published private(set) var people: [Prospect]
    
    init() {
        // Wrap up - Challenge 2 - save data to documents directory
        if let data = try? Data(contentsOf: Self.documentsUrl) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
        
        self.people = []
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    private func save() {
        if let encodedData = try? JSONEncoder().encode(people) {
            // Wrap up - Challenge 2 - save data to documents directory
            try? encodedData.write(to: Self.documentsUrl, options: [.atomicWrite])
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
