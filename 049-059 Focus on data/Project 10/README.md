# CupcakeCorner
A multi-screen app for ordering cupcakes

![App screenshot](CupcakeCorner.png)


## Adding Codable conformance for @Published properties
- for properties wrapped by @Published to conform to Codable, the class needs a custom init and encoder function
- to implement this, an enum conforming to the `CodingKey` protocol is used
- conforming simply means that every case in the enum is the name of a property that should be loaded/saved
- this enum is commonly called **CodingKeys** (with an s at the end)
- the initializer should be marked with __required__ or alternatively the class should be marked __final__
- both the `init(from:)` and `encode(to:)` functions need an argument of type **Decoder** and **Encoder** respectively
- inside them a __container__ is created from the decoder/encoder argument, e.g: `let container = try decoder.container(keyedBy: CodingKeys.self)`
- the `keyedBy:` argument ensured that the container has keys matching those in the CodingKeys enum
- after that all the properties need to be decoded (loaded, in the init) or encoded (saved, in the encode function)
- this is done via `propertyName = container.decode(Type.self, forKey: .propertyName)` and `try container.encode(propertyName, forKey: .propertyName)`

## Sending and receiving Codable data with URLSession and SwiftUI
- 

## Validating and disabling forms
- 

## Wrap up - Challenges
- 
