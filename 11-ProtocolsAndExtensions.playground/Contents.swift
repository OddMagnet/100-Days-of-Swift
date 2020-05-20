import UIKit

// Protocols
// are a way of describing what properties and methods something must have
// Swift can be told which types use a protocol, this is known
// as 'adopting' or 'conforming' to a protocol
// properties must be marked with { get } if they need to be readable
// and with { get set } if they need to be writeable too
// it's not possible to mark a property as just writeable

protocol Identifiable {
    var id: String { get set }
}
// this protocol requires conforming types to have an id string
// and that string must be readable (get) and writeable (set)

struct User: Identifiable {
    var id: String
}
// this struct conforms to the 'Identifiable' protocol

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}
// function can also have parameters that need to conform to a protocol



// Protocol inheritence
// protocols also can inherit, but unlike classes a single protocol
// can inherit from multiple protocols at the same time

protocol Payable {
    func calculateWages() -> Int
}
protocol NeedsTraining {
    func study()
}
protocol HasVacation {
    func takeVacation(days: Int)
}

protocol Employee: Payable, NeedsTraining, HasVacation {}
// this protocol inherits from 3 different protocols



// Extensions
// allow for adding of additional methods to existing types
// it's also possible to add computed properties
// adding stored properties is not possible

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    func squared() -> Int {
        return self * self
    }
}

8.isEven
8.squared()



// Protocol Extensions
// protocols only describe what methods something should have, but provide no code
// extensions provide code but can only affect one data type
// protocol extensions solve both those problems
// instead of extending a specific type they extend a whole protocol,
// so all conforming types get the new code

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])
// both arrays and sets conform to a protocol called 'Collection'

extension Collection {
    func summarize() {
        print("There are \(count) of us:")
        
        for name in self {
            print(name)
        }
    }
}
// after writing an extension to the 'Collection protocol'...

pythons.summarize()
beatles.summarize()
// both arrays and sets can use the code



// Protocol-oriented programming
// is the technique of crafting code around protocols and their extensions
// this is useful for making multiple types conform to the same protocol
// and avoid code duplication

protocol Identifiable2 {
    var id: String { get set }
    func identify()
}

extension Identifiable2 {
    func identify() {
        print("My ID is \(id).")
    }
}

struct User2: Identifiable2 {
    var id: String
}

let oddmagnet = User2(id: "OddMagnet")
oddmagnet.identify()



// Protocols and extensions summary
// Protocols describe what methods and properties a conforming type must have
// They can inherit from other protocols
// Extensions allow for adding methods and computed properties to existing types
// Protocol extensions allow for adding methods and computed properties to protocols
// Protocol-oriented programming is the practice of designing the app architecture
// as a series of protocols and using extensions to provide default method implementations
