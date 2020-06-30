//
//  OnlineIndicator.swift
//  FriendFace
//
//  Created by Michael Brünen on 30.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct OnlineIndicator: View {
    var isActive: Bool
    
    var body: some View {
        Circle()
            .foregroundColor(isActive ? .green : .gray)
            .frame(width: 12, height: 12)
    }
}

struct OnlineIndicator_Previews: PreviewProvider {
    static var previews: some View {
        OnlineIndicator(isActive: true)
    }
}
