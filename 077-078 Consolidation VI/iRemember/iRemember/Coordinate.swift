//
//  Coordinate.swift
//  iRemember
//
//  Created by Michael Brünen on 13.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import Foundation
import MapKit

struct Coordinate: Codable, Hashable {
    let latitude, longitude: Double
}

extension CLLocationCoordinate2D {
    init(_ coordinate: Coordinate) {
        self = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

extension Coordinate {
    init(_ coordinate: CLLocationCoordinate2D) {
        self = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}
