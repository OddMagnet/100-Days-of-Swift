import UIKit

// Handling missing data
// to handle potentially missing/unknown data, optionals can be used
// simply adding a '?' to the type of a variable makes it optional

var age: Int? = nil



// Unwrapping optionals
// since optionals may contain no data at all, they must be
// before they can be used

if let unwrapped = age {
    print("The age is \(unwrapped)")
} else {
    print("No age given")
}
// the 'if let' syntax is a common way to unwrap optionals



// Unwrapping with guard
// is an alternative to the 'if let' syntax
// if there is no value inside the optional, it is expected
// that the function, loop or condition 'guard let' was
// used inside is exited
// The major difference between 'if let' and 'guard let' is
// that the unwrapped optional remains usable after the
// 'guard' code

func birthday(_ age: Int?) {
    guard let unwrapped = age else {
        print("No age specified")
        return
    }
    
    print("Happy \(unwrapped)th Birthday!")
}
// guard let allows for immediate exit if an optional is nil



// Force unwrapping
// it's also possible to 'force unwrap' an optional
// by adding an '!' to the optional
// If the optional does not hold a value, the code will crash
// thus this should only be used if it's absolutely certain
// that it holds a value

let str = "5"
let optionalNum = Int(str)
let forcedNum = Int(str)!



// Implicitly unwrapped optionals
// might contain a value or might be nil, just like regular optionals
// unlike regular optionals they don't be unwrapped and can be used
// as if they weren't optionals at all
// Implicitely unwrapped optionals are created by adding an '!'
// after their type name
// However, they will crash the code when used while they are nil
// they're mainly useful for variables that start as nil but will
// have a value before they are used

let name: String! = nil
// this property will crash the code if used
// If possible regular optionals are always better than implicitely unwrapped ones



// Nil coalescing
// the 'nil coalescing' operator '??' unwraps and returns a value if there is one
// if not, a default value will instead be returned

func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

let user = username(for: 15) ?? "Anonymous"
// here the 'nil coalescing' operator will return the default value



// Optional chaining
// if an optional in a chain of methods/properties has no value,
// nil will be returned and the rest of the chain will be ignored
// if it has a value that value will be unwrapped and execution continues

let names = ["John", "Paul", "George", "Ringo"]

let beatle = names.first?.uppercased()
// an example of optional chaining



// Optional try
// aside from the normal 'try' for throwing functions there also exist:
// 'try?' which changes throwing functions into function that return an optional
// if the function throws an error nil will be returned, otherwise the return value
// wrapped as an optional
// and 'try!' which will crash the code should the function throw an error
// as with forced unwrapping this should be avoided being used whenever possible

enum PasswordError: Error {
    case obvious
}
func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}

let result: Bool? = try? checkPassword("password")
// using 'try?' the function will return either nil or the return value will
// be wrapped as an optional



// Failable initializers
// it's possible to write 'failable initializers' which return an optional or nil
// using 'init?()' and returning 'nil' if something goes wrong

struct Person {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}



// Typecasting
// is used to 'cast' something to a certain type using the 'as?' keyword
// which returns an optional which will be 'nil' if the typecast failed
// or a converted type otherwise

class Animal {}
class Fish: Animal {}
class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}
let pets = [Fish(), Dog(), Fish(), Dog()]
// since both 'Fish' and 'Dog' inherit from 'Animal', Swift will use
// type inference to make this an array of type 'Animal'

for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}
// using the 'as?' keyword it's possible to loop over this array
// and use the 'makeNoise' function for every 'Dog' item



// Optionals summary
// Optionals represent the absence of a value
// Swift does not allow using optionals without unwrapping
// both 'if let' and 'guar let' can be used to unwrap an optional
// It's possible to force unwrap using an '!', but if the optional is nil the code will crash
// Implicitly unwrapped optionals don't have the safety checks of regular optionals
// Optional chaining allows for manipulating an optional, but if the
// optional is empty the code following it will be ignored
// It's possible to use 'try? to convert a throwing function into an optional return value
// or 'try!' which will crash when the function throws an error
// To create a failable initializer 'init?()' is used
// Typecasting can be used to convert one type of object to another
