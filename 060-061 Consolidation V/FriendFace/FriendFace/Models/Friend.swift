//
//  Friend.swift
//  FriendFace
//
//  Created by Michael Brünen on 28.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import Foundation

struct Friend: Codable, Identifiable {
    let id: UUID
    let name: String
}

// Example data
/*
 id      "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0"
 name    "Hawkins Patel"
 */
