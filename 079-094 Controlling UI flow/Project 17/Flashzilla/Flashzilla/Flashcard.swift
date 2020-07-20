//
//  Flashcard.swift
//  Flashzilla
//
//  Created by Michael Brünen on 20.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import Foundation

struct Flashcard {
    let prompt: String
    let answer: String

    static var example: Flashcard {
        Flashcard(prompt: "What would be an appropriate answer for this example prompt?", answer: "Example Answer")
    }
}
