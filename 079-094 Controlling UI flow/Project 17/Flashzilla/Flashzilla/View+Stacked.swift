//
//  View+Stacked.swift
//  Flashzilla
//
//  Created by Michael Brünen on 20.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int, by factor: CGFloat) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * factor))
    }
}
