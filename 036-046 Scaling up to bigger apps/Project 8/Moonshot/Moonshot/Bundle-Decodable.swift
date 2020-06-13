//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Michael Brünen on 13.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import Foundation

extension Bundle {
    // decode a generic Type T - that conforms to Codable - and return that type
    // for this project that will be either [Astronaut] or [Mission]
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in the bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from the bundle")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from the bundle")
        }
        
        return loaded
    }
}
