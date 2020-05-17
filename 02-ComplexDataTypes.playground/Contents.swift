import UIKit

// Arrays
// are a collection of values stored as a single value
// a variable can hold a single string, an array can hold a collection of strings
// type annotations for array use brackets arround the type: [String], [Int], [Double], [Bool]

let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]
// arrays start and end with brackets, seperating each item with a comma

beatles[1]
// to read a value from an array, a number inside brackets is used
// indices start at 0, trying to access an index that doesn't exist will crash the program



// Sets
// are a collection of values, like an array
// but they aren't stored in any order, they are effectively random
// all their items must be unique, no item can appear twice
// to create a set the 'Set' function is called and an array of values is passed

let colors = Set(["red", "green", "blue"])
// the order in the playground output is unordered

let colors2 = Set(["red", "green", "blue", "red", "blue"])
// duplicates get ignored, see the playground output



// Tuples
// allow for storage of several values in a single value
// different from an array, items can't be removed or added after creation,
// the type of the items in the tuple can't be changed, only the value,
// and the items can be accessed by using numerical positions or naming them

var name = (first: "Taylor", last: "Swift")
// tuples are created by placing multiple items in parentheses

name.0
name.first
// they can be accessed numerically or by name



// Arrays vs Sets vs Tuples
// while similiar, each has their own distinct use

let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")
// for a specific, fixed collection of related values, where each item has a position or name,
// Tuples are best suited

let set = Set(["aardvark", "astronaut", "azalea"])
// for a collection of values that must be unique or needs to be able to check quickly,
// if it contains an item, Sets are best suited

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
// for a collection that can contain duplicates or where the order of items matters,
// Arrays are best suited



// Dictionaries
// are a collection of values like array, but use keys instead of indices as identifiers
// keys can be anything, but most commonly are strings
// like arrays they start and end with brackets and items are seperated by a comma
// the keys are seperated from their value with a colon
// when using annotations, dictionaries are written in brackets with a colon between key and value

let heights: [String: Double] = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
// here the strings on the left are the keys, the doubles on the right the values

heights["Taylor Swift"]
// to access a value, the bracket notation is used, just like with arrays



// Dictionary default values
// when reading a value of a key that does not exist, Swift will send back 'nil'
// to avoid this, default values can be used

heights["OddMagnet", default: 1.78]
// if the key does not exist, the default value will be returned



// Creating empty collections
// arrays, sets and dictionaries are collections, because they collect values in one place
// to create an empty collection, use the 'Array', 'Dictionary' or 'Set' function,
// followed by the type in angle brackets and then opening and closing parentheses
// Swift has a special syntax for arrays and dictionaries, which makes it possible
// to only write the type(s) in brackets followed by the opening and closing parentheses

var teams1 = Dictionary<String, String>()
var teams2 = [String: String]()
// both examples create an empty dictionary, the later is more common
teams1["Paul"] = "Red"
// adds an entry to the dictionary

var results1 = Array<Int>()
var results2 = [Int]()
// both examples create an empty array, the later is more common

var words = Set<String>()
// for a set only this syntax is possible



// Enumerations
// most commonly called 'enums' are used to define groups of related values for ease of use
// a common example would be to represent the success or failure of something
// to create an Enumeration, the 'enum' keyword is used, followed by the name of it
// inside the curly braces are then the different possible values, marked by the 'case' keyword

enum Result {
    case success
    case failure
}
let result = Result.failure
// this way the value can't be accidentally mistyped



// Enum associated values
// aside from storing simple values, enums can also store associated values attached to each case
// this lets them represent more nuanced data

enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}
let talking = Activity.talking(topic: "programming")
// associated values are added in parentheses, containing the name and type of the value)



// Enum raw values
// it's also possible to assign values to enums
// this enables dynamic creation of enums and different uses
// the name of the enum is followed by a colon and the type of the associated values

enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
}
let earth = Planet(rawValue: 2)
// by default Swift assigns a number to each case, starting with 0

enum Planet2: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}
// it's also possible to assign a value to one or more cases and Swift will generate the rest
// this would make the value of the case 'earth' 3



// Compley types: Summary
// Arrays, sets, tuples and dictionaries are used to store a group of items under a single value
// They all work in different ways and what is used depends on the behaviour that is required
// Arrays store in the order items are added and use numerical positions for access
// Sets store without order and can't be accessed using numerical positions
// Tuples are fixed in size and can have names attached to their items
// Tuple items can be read using numerical positions or using the corrosponding names
// Dictionaries store items according to a key and can be read using those keys
// Enums are used to group related values
// It's possible to attach raw values to enums so they can be created from integers or strings
// It's possible to add associated values to enums, to store additional information for cases
