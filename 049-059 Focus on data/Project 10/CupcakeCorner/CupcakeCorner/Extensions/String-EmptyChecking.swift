//
//  String-EmptyChecking.swift
//  CupcakeCorner
//
//  Created by Michael Brünen on 04.01.22.
//  Copyright © 2022 Michael Brünen. All rights reserved.
//

import Foundation

extension String {
    /// Checks if a string is really empty
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
