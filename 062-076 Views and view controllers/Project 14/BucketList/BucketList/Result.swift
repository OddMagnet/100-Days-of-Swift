//
//  Result.swift
//  BucketList
//
//  Created by Michael Brünen on 07.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}
