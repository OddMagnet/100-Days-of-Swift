//
//  Part2.swift
//  HotProspects
//
//  Created by Michael Brünen on 14.07.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

struct Part2: View {
    @State private var returnValue = ""
    
    var body: some View {
        Section(header: Text("Part 2")) {
            
            NavigationLink("Understanding Swift’s Result type", destination:
                Text("Returned value: \(returnValue)")
                .onAppear {
                    self.fetchData(from: "https://reqbin.com/echo/get/json") { result in
                        switch result {
                        case .success(let str):
                            print("Returned: " + str)
                            self.returnValue = str.trimmingCharacters(in: .whitespaces)
                        case .failure(let error):
                            switch error {
                            case .badURL:
                                self.returnValue = "Bad URL"
                            case .requestFailed:
                                self.returnValue = "Request failed"
                            case .unknown:
                                self.returnValue = "Unknown failure"
                            }
                        }
                    }
                }
            )
            
            NavigationLink("Placeholder", destination:
                Text("Placeholder")
            )

            NavigationLink("Placeholder", destination:
                Text("Placeholder")
            )

        }
    }
    
    // Version 1: Blocking
//    func fetchData(from urlString: String) -> Result<String, NetworkError> {
//        .failure(.badURL)
//    }
    
    // Version 2: Non-blocking via closure
//    func fetchData(from urlString: String, completion: (Result<String, NetworkError>) -> Void) {
//        completion(.failure(.badURL))
//    }
    
    // Version 3: Non-blocking with @escaping closure to retain whatever called this function
//    func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
//        DispatchQueue.main.async {
//            completion(.failure(.badURL))
//        }
//    }
    
    // Version 4: Final, with actually getting and handling data
    func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        // check if URL is valid
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // get bacl to main thread after task completion
            DispatchQueue.main.async {
                if let data = data {
                    // success
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                } else if error != nil {
                    // any network failure
                    completion(.failure(.requestFailed))
                } else {
                    // both data and error were nil, this should not be possible in theory
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }


}

struct Part2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Part2()
            }
        }
    }
}
