//
//  Part1.swift
//  CupcakeCorner
//
//  Created by Michael Brünen on 20.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

class User: ObservableObject, Codable {
    // properties wrapped in the @Published wrapper don't automatically conform to Codable
    @Published var name = "Odd Magnet"
    
    // every case in this enum is a property that needs to be able to be loaded and saved
    enum CodingKeys: CodingKey {
        case name
    }
    
    // init adds conformance to decodable
    // decoder contains the data
    // required just means when subclassing from this class, the initilizer must be overridden
    // so it can handle new custom properties, alternatively the class could be marked final
    required init(from decoder: Decoder) throws {
        // create a contrainer from the supplied data (decoder) with keys that match the cases from the enum
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // then read values from the container, by referencing the keys, and assign them to the variables
        name = try container.decode(String.self, forKey: .name)
    }
    
    init(name: String) {
        self.name = name
    }
    
    // encodes adds conformance to encodable
    // encoder is where the data is written to
    func encode(to encoder: Encoder) throws {
        // again create a container
        var container = encoder.container(keyedBy: CodingKeys.self)
        // and use it to write the values to the encoder instance
        try container.encode(name, forKey: .name)
    }
}

struct Part1: View {
    @State private var userName = ""
    
    var body: some View {
        NavigationView {
        //Section(header: Text("Part 1")) {
        List {
            
            NavigationLink("Test", destination:
                VStack(alignment: .leading) {
                    TextField("Name", text: $userName)
                    Button("Save name") {
                        let encoder = JSONEncoder()
                        let user = User(name: self.userName)
                        if let data = try? encoder.encode(user) {
                            UserDefaults.standard.set(data, forKey: "UserName")
                        }
                    }
                    Button("Clear name") {
                        self.userName = ""
                    }
                    Button("Load name") {
                        if let data = UserDefaults.standard.data(forKey: "UserName") {
                            let decoder = JSONDecoder()
                            if let user = try? decoder.decode(User.self, from: data) {
                                self.userName = user.name
                            }
                        } else {
                            self.userName = "Could not be loaded"
                        }
                    }
                }
                .padding()
            )
            
            NavigationLink("Test", destination:
                Text("LinkedView")
            )

            NavigationLink("Test", destination:
                Text("LinkedView")
            )
            
        }
        }
    }
}

struct Part1_Previews: PreviewProvider {
    static var previews: some View {
        Part1()
    }
}
