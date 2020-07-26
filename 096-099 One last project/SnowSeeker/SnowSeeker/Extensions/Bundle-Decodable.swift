//
//  Bundle-Decodable.swift
//  SnowSeeker
//
//  Created by Michael Brünen on 26.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        // Check for file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        // try to load file
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        // try to decode file
        guard let loaded = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        // return on success
        return loaded
    }
}
