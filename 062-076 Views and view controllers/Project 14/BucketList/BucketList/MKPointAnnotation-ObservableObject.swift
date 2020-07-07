//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Michael Brünen on 07.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "No title"
        }
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "No subtitle"
        }
        set {
            subtitle = newValue
        }
    }
}
