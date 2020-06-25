//
//  PushButton.swift
//  Bookworm
//
//  Created by Michael Brünen on 24.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: isOn ? onColors : offColors),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct PushButton_Previews: PreviewProvider {
    static let title = "Title"
    @State static var isOn = true
    static var previews: some View {
        PushButton(title: title, isOn: $isOn)
    }
}
