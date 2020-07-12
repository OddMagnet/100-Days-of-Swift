//
//  PersonDetailView.swift
//  iRemember
//
//  Created by Michael Brünen on 12.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

struct PersonDetailView: View {
    var person: Person
    
    var body: some View {
        VStack {
            Image(uiImage: person.image)
                .resizable()
                .scaledToFit()
                .padding()
                .navigationBarTitle("\(person.firstName) \(person.lastName)")
            
            Spacer()
        }
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PersonDetailView(person: Person(firstName: "Test", lastName: "Person", image: UIImage(systemName: "camera")!))
        }
    }
}
