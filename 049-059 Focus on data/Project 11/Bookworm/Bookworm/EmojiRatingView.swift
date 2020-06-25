//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by Michael Brünen on 25.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int16

    var body: some View {
        switch rating {
        case 1:
            return Text("🤮")
        case 2:
            return Text("😞")
        case 3:
            return Text("🙂")
        case 4:
            return Text("😃")
        default:
            return Text("😍")
        }
    }
}
struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
