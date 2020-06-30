//
//  CodingUserInfoKey+context.swift
//  FriendFace
//
//  Created by Michael Brünen on 29.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import Foundation

// add property to save the context so it can be set on the decoder and used in the init() of the decoding class
extension CodingUserInfoKey {
   static let context = CodingUserInfoKey(rawValue: "context")
}
