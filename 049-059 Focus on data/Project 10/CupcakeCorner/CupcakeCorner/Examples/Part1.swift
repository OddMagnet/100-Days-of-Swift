//
//  Part1.swift
//  CupcakeCorner
//
//  Created by Michael Brünen on 20.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

// Adding Codable conformance for @Published properties
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

// Sending and receiving Codable data with URLSession and SwiftUI
struct Response: Codable {
    var results: [Result]
}
struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct Part1: View {
    @State private var userName = ""
    @State private var results = [Result]()
    
    var body: some View {
        NavigationView {
        //Section(header: Text("Part 1")) {
        List {
            
            NavigationLink("Adding Codable conformance for @Published properties", destination:
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
            
            NavigationLink("Sending and receiving Codable data with URLSession and SwiftUI", destination:
                VStack {
                    List(results, id: \.trackId) { item in
                        VStack(alignment: .leading) {
                            Text(item.trackName)
                                .font(.headline)
                            Text(item.collectionName)
                        }
                    }
                    .onAppear(perform: loadData)
                }
                .padding()
            )

            NavigationLink("Test", destination:
                Text("LinkedView")
            )
            
        }
        }
    }
    
    func loadData() {
        // create URL to load data from
        guard let url = URL(string: "https://itunes.apple.com/search?term=metallica&entity=song") else {
            print("Invalid url")
            return
        }
        
        // create a request based on the URL
        let request = URLRequest(url: url)
        
        // it's posssible to create a custom session instead of using the provided 'shared' session
        // the call to dataTask(with:) on the shared session creates the networking task from the specified request
        // and requires a closure that is run on completion and is provided with:
        // - data : whatever data was returned from the request
        // - response : a description of the data, e.g. type, size, status code, etc
        // - error : the error that occured, if any
        // data and error are mutually exclusive, only one of them will be set
        // the call to resume() is needed to actually start the call, without it nothing will happen
        // since this task runs on a background thread, the resulting data needs to be sent back to the
        // main thread, since that's where SwiftUI's UI runs
        URLSession.shared.dataTask(with: request) { data, response, error in
            // check that data is set
            if let data = data {
                let decoder = JSONDecoder()
                // decode the response
                if let decodedResponse = try? decoder.decode(Response.self, from: data){
                    // on success, send the data back to the main thread, this will be run asynchronous
                    DispatchQueue.main.async {
                        // update the UI
                        self.results = decodedResponse.results
                    }
                    // everything is done -> exit
                    return
                }
            }
            
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct Part1_Previews: PreviewProvider {
    static var previews: some View {
        Part1()
    }
}
