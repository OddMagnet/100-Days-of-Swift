import UIKit

// Creating your own structs
// Structures, commonly called 'structs' are custom data types
// Variables inside them are called properties

struct Sport {
    var name: String
}
// creation of a struct, this defines the type

var tennis = Sport(name: "Tennis")
// creating a variable of the custom type 'Sport'
print(tennis.name)

tennis.name = "Lawn tennis"
// both 'tennis' and 'name' are variables, so they can change



// Computed properties
// different from store properties, computed properties
// run code to 'figure out' their value
// they must always have an explicit type

struct Sport2 {
    var name: String
    var isOlympicSport: Bool
    
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}
// this struct has a computed property called 'olympicStatus'
// which returns different values depending on other properties

let chessBoxing = Sport2(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)



// Property observers
// allow for code to be run before or after any property changes
// to run code before a property changes, 'willSet' is used
// to run code after a propery changed, 'didSet' is used

struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100



// Methods
// are functions inside structs
// they use the same 'func' keyword as normal functions

struct City {
    var population: Int
    
    func collectTaxes() -> Int {
        return population * 1_000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes()



// Mutating methods
// by default it's not possible for a method
// to change a property of the struct it belongs to
// only methods marked with the 'mutating' keyword
// can change properties of their struct

struct Person {
    var name: String
    
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()



// Properties and methods of strings
// under the hood strings are stucts too
// and also have their own methods

let string = "Do or do not, there is no try."

print(string.count)             // returns the character count
print(string.hasPrefix("Do"))   // returns true or false
print(string.uppercased())      // returns an uppercased version of the string
print(string.sorted())          // returns an array of the sorted letters of the string
// some examples of methods the string struct has



// Properties and methods of arrays
// just like strings arrays are also structs
// and thus also have their own methods and properties

var toys = ["Woody"]

print(toys.count)               // returns the item count
toys.append("Buzz")             // adds a new item to the array
toys.firstIndex(of: "Buzz")     // returns the index of the first appearance of an item
print(toys.sorted())            // returns an alphabetically sorted array
toys.remove(at: 0)              // removes the item at the specified position
// some examples of methods of the array struct



// Initializers
// are special methods that provide different ways to create a struct.
// All structs have a default initializer, called their 'memberwise initializer'
// Custom initializers cannot finish before all properties have a value

struct User {
    var username: String
}
var user = User(username: "oddmagnet")
// example of the default initializer

struct CustomUser {
    var username: String
    
    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}
var customUser = CustomUser()
customUser.username = "oddmagnet"
// example of a custom initializer



// Referring to the current instance
// Inside methods Swift provides a special constant called 'self',
// which points to the instance of the struct that is being used
// This is useful when the initializers have the same parameter
// names as the properties

struct newPerson {
    var name: String
    
    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}
// example of the 'self' keyword



// Lazy properties
// are used as a performance optimization
// Swift will only create a lazy property when it's first accessed

struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct FamilyGuy {
    var name: String
    lazy var familyTree = FamilyTree()
    
    init(name: String) {
        self.name = name
    }
}

var peter = FamilyGuy(name: "Peter Griffin")
peter.familyTree
// the property 'familyTree' will only be created when it's first accessed



// Static properties and methods
// are shared across all instances of a struct

struct Student {
    static var classSize = 0
    var name: String
    
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}
// every time a variable of type 'Student' is created, the classSize grows
// static properties need to be accessed using the type / struct name

let chris = Student(name: "Chris")
print(Student.classSize)
let meg = Student(name: "Meg")
print(Student.classSize)
// static properties/methods have to be accessed using the type instead of an instance



// Access control
// restricts which code can user properties and methods
// this is useful to make sure properties/methods don't get read/called directly
// to restrict access to a property/method the 'private' keyword is used
// those properties/methods can then only be accessed from inside the struct

struct Adult {
    private var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
        return "My social security number is: \(id)"
    }
}
// the id property can't be accessed directly from the outside



// Structs summary
// custom types can be created using structs
// they can have their own properties and methods
// it's possible to use computed properties to calculate values on the fly
// only 'mutating' functions can change properties inside their struct
// Initializers are special methods to create structs instances
// it's possible to create a custom initializer
// the 'self' keyword refers to the current instance of a struct
// the 'lazy' keyword tells Swift to only create properties on the first access
// the 'static' keyword allows for properties to be shared across all instances of a struct
// the 'private' keyword restricts usage of properties and methods to inside the struct
