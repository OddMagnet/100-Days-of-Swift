import UIKit

// Variables and constants
// there are 2 ways of storing data in Swift, variables and constants
// a variable can have its value changed at any point
// a constant can only be set once and then never change again
// Constants are used to make sure that data isn't accidentally changed additionally Xcode will be able to apply optimizations if it knows a value will never change
// In general it is recommended to use constants whenever and whereever possible
// Lastly, variable and constant names must be unique

var vname = "Tim McGraw"
// as a variable this can be changed at any point
vname = "Romeo"
// the 'var' keyword is only needed when initially declaring the variable

let cname = "Tim McGraw"
// as a constant, this can't be changed anymore
//cname = "Romeo"
// the above line would cause a warning and stop code from compiling



// Types of Data
// Some of the most important types in Swift are:
// - String: store a series of characters, or the empty string ""
// - Integer: store simple, round numbers
// - Float and Double: store numbers with fractional components, Double has more precision
// - Boolean: store either 'true' or 'false'
// Swift is a strongly typed language, meaning that it needs to know the type of every variable and constant
// This can be accomplished by either giving a value when declaring it (type inference) or by providing a so called 'type annotation'
// Knowing the type of every variable, Swift can guarantee 'type safety' that means it's not possible to assign, for example, an integer to a string

let stringExample = "Example"
let intExample = 42
let doubleExample = 3.1415926
let boolExample = true

let infered = "The type of this string comes from type inference"
var annotated: String
annotated = "The type of this string came from a type annotation"
// when possible, type inference is always prefered over type annotations
// tpye annotation should only be used when there is no initial value



// Operators
// Swift supports all basic operators and some more
// '+' addition, '-' subtraction, '*' multiplication and '/' division
// All basic operators can be combined with the equals sign '=' on the right side to apply the operation and assign the new value to the variable on the left
// For strings only the '+' operator can be used, it can join two strings
// Another common operator is the modulus operator '%', it returns the remainder of a division
// Lastly, swift also has comparion operators for less than '<', greater than '>', less than or equal '<=', greater than or equal '>=', exactly equal '==', not equal '!=' and the not operator '!' which makes a statement mean the opposite

var a = 10  // v is the same as v
a += 10     // a = a + 10
a /= 2      // a = a / 2
a -= 5      // a = a - 5
a *= 2      // a = a * 2

let firstName = "Odd"
let lastname = "Magnet"
let fullName = firstName + lastname

let b = 10 % 3  // remainder will be 1

a < b           // true if a is smaller than b
a <= b          // true if a is smaller than or equal to b
a > b           // true if a is bigger than b
a >= b          // true if a is bigger than or equal to b
a == b          // true if a is exactly equal to b
a != b          // true if a is not equal to b
!boolExample    // returns the opposite of the



// String interpolation
// is used to combine strings with variables and constants
// Swift can handle combining strings with a variety of different data types
// Additionally everything between the '\(' and ')' can be a full Swift expression

var msg = "Hello \(fullName)"
var age = 28
print("In another \(age) years you'll be \(age*2)")



// Arrays
// group values into a single collection
// those values can be accessed by their index (starting at 0)
// trying to access an index that does not exist will crash the code
// type annotations for arrays simply put the type in '[]'
// Arrays only support a limited set of operators, '+' and '+='

var evenNumbers = [2, 4, 6, 8]
// using type inference Swift knows this is an array of Ints
print("Array type is: \(type(of: evenNumbers))")
let firstEvenNumber = evenNumbers[0]

var emptyArray1: [String] = []  // using type annotation
var emptyArray2 = [String]()    // using type inference
// these both create an empty array that can hold strings

var songs = ["Shake it Off", "You Belong with Me", "Love Story"]
var songs2 = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]
var both = songs + songs2
both += ["Everything has Changed"]
// arrays can be merged with '+' or appended with '+='



// Dictionaries
// are a another common kind of collection which use keys
// instead of indices to access values in them
// their entries consists of 'key: value' pairs seperated by commas

var person = [
    "first": "Taylor",
    "middle": "Alison",
    "last": "Swift",
    "month": "December"
]
// for better readability they're often broken up instead of all in one line

person["middle"]
person["month"]
// instead of an index a key is used to access a value



// Conditional statements
// to only execute code when a certain condition is true, 'if' and 'else'statements are used, after the 'if' keyword follows the condition, then the block of code to be executed, surrounded by '{' and '}'
// optionally more conditions and code can be added by using 'else if' or a default block of code can be executed by just adding 'else'
// To evaluate multiple conditions either the and '&&' operator or the or '||' operator can be used
// To negate a condition the not operator '!' is used

if fullName == "OddMagnet" {
    print("This is the 'if' code block")
} else if fullName == "Paul Hudson" {
    print("This is the 'else if' code block")
} else {
    print("This is the 'else' code block")
}
// example of 'if', 'else if' and 'else' usage

if firstName == "Odd" && lastname == "Magnet" { /* code */ }
if fullName == "OddMagnet" || fullName == "Paul Hudson" { /* code */ }
// for '&&' code will only be executed if both conditions are true
// for '||' code will be executed as long as one condition is true



// Loops
// are used to repeatedly execute code, there are a few kind of loops:
// 'for in' loops which use either ranges or arrays to loop over and assign the current item to a constant to be used inside the loop
// 'while' loops, which run as long as the given condition is true or just use 'true' to run endlessly
// Loops support 2 special keywords, 'break' and 'continue'
// 'break' completely exits the loop while 'continue' only moves to the next cycle
// It's also possible to use loops inside loops, then called 'inner loops'

for i in 10...20 {
    if i == 13 {
        continue
    }
    print("\(i) x 10 is \(i * 10)")
}
// example of a 'for in' loop used with a range and the 'continue' keyword

for song in songs {
    print(song)
}
// example of a 'for in' loop used with an array

var counter = 0
while counter < 10 {
    counter += 1
}
// example of a 'while' loop which runs as long as the counter is less than 10

while true {
    counter += 1
    if counter == 20 {
        break
    }
}
// example of an endless 'while' loop and the 'break' keyword



// Switch case
// can be thought of as an advanced form of 'if', in 'switch' a variable will be checked and the code from the fitting 'case' will be executed
// An advantage of 'switch case' is that Swift ensures it is exhaustive, which means all cases are covered
// The 'default' keyword can be used to supply code that executes when nothing else matches
// In Swift the 'case' blocks don't 'fall through', meaning only the first fitting case will be executed. To also execute the next fitting cases the 'fallthrough' keyword is used

let liveAlbums = 2
switch liveAlbums {
case 0:
    print("You're just starting out")
case 1:
    print("You just released iTunes Live From SoHo")
case 2:
    print("You just released Speak Now World Tour")
default:
    print("Have you done something new?")
}

let fallthroughExample = 1
switch fallthroughExample {
case 0...1:
    print("First case")
    fallthrough
case 0...5:
    print("Second case")
case 0...10:
    print("Third case")
default:
    print("Final case")
}
// example of the 'fallthrough' keyword






// Functions
// are re-usable pieces of code that perform specific pieces of functionality
// The 'func' keyword is used to define a function, followed by its name, its parameter list in parentheses, the return type and finally the code-block in curly braces
// Parameters are followed by a colon and their type it's possible to specify two names for a parameter, an internal and an external name, to omit the external name in function calls, an underscore is used in the definition
// The return type follows the parameter list, preceded by a '->', functions can only return values of the type that is specified by the return type
// A function is called using its name followed by its arguments (if any) in parenthenses, multiple functions with the same name can exist, as long as their parameters are different, this can be useful to have for example multiple 'parse' function that support different input data

func getAlbumRelease(name: String, from year: Int) -> String {
    return "\(name) was release in \(year)"
}
print(getAlbumRelease(name: "Master of Puppets", from: 1986))



// Optionals
// represent a variable/constant that might hold a value or might not
// Optional variables/constants can be created by adding a '?' to the type annotation
// Functions can have an optional return value by adding a '?' to the return type
// To use optionals they must be unwrapped, this can be done with 'if let' or 'guard let'
// - 'if let' uses a conditional statement that checks if the optional has a value, and if so unwraps it into a non-optional type and then runs the following code block if the optional has no value, the 'else' code block (if present) is run
// - 'guard let' works similiar to 'if let' but the unwrapped value is not limited to a code block, instead 'guard let' only unwraps and has an 'else' code block in case that the optional had no value. After unwrapping the constant with the unwrapped value can be used like a normal constant
// It's possible to 'force unwrap' optionals using the exclamation mark '!' character this should be used carefully and if possible avoided, if an empty optional is force unwrapped the code will crash
// Implicitly unwrapped optionals use '!' instead of '?' for the type annotation they don't need to be unwrapped before using them, but will still crash the code when they're used while empty

func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}

func takeHaterAction(status: String) {
    if status == "Hate" {
        print("Hating")
    }
}

if let haterStatus = getHaterStatus(weather: "rainy") {
    takeHaterAction(status: haterStatus)
}



// Optional chaining
// is a technique that only runs code when the optional has a value
// to use it a question mark '?' is added after the optional and before the next part of the chain
// another technique to help with optionals is the 'nil coalescing operator': '??'
// it provides a default value for the code ot use in case the optional was empty


func mightBeOptional() -> String? {
    return "Hello, World!"
}

let returnedValue = mightBeOptional()?.uppercased() // optional chaining
print(returnedValue ?? "Seems it was empty")        // nil-coalescing operator



// Enumerations
// are used to define custom data types in Swift
// they are useful to avoid using strings when a 'multiple choice' kind of type would be better
// when using a custom enum type as a parameter type, the function can only accept valid values, unlike strings, which would need to be typed correctly
// they're created by using the 'enum' keyword, followed by their name and their possible cases in curly braces
// they can be on the same line, but usually each case gets his own line
// when comparing them in a condition the cases can be used like '.case' instead of 'Type.case'
// they're particularly useful in 'switch case' because Swift knows all their value and can make sure the 'switch case' is exhaustive
// cases can have additional values attached, they're used like a parameter list following the case, these additional values can also be checked, using 'let value' in parenthenses after the case name and then followed by the 'where' keyword and condition

enum WeatherType {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}

func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "meh"
    case .cloud, .wind:
        return "dislike"
    default:
        return "hate"
    }
}

getHaterStatus(weather: .cloud)



// Structs
// are custom data types that are made up of multiple values
// they offer a default initializer, called the 'memberwise initializer'
// properties of an instance of a struct can be read like this 'instance.property'
// When assigning one struct to another, Swift copies the original struct
// both structs are then standalone, different from classes (see below)
// It's possible to have functions inside structs, which are then called methods

struct Person {
    var name: String
    let birthyear: Int
    
    func describe() {
        print("\(name) was born in \(birthyear)")
    }
}

let oddmagnet = Person(name: "OddMagnet", birthyear: 1992)
oddmagnet.describe()



// Classes
// are custom data types like structs, but have some important differences
// - no default initializer, they need a custom one written for them
// - they can inherit from other classes
// - an instance of a class is called an 'object', they are create like struct instances
// - both a copy of an object and the original point to the same data this means that changing one changes the other too
// the initializer for a class is created by writing an 'init()' method this method does not need the 'func' keyword and needs to initialize - give values - to all of the classes non-optional properties unless they have a default value
// inside methods the 'self' keyword is used to access the classes properties
// inheriting from another class (the 'parent' class) allows the 'child' class, which is the one that inherits, to use all the properties and methods of the parent class to inherit from another class, the class name is followed by a colon and then the parents name
// when initializing a call to the parent class is made via 'super.init(...)'
// to change a methods behaviour in a child class, the 'override' keyword is used, after which the method is then redefined and rewritten
// if a class's method needs to be called by part of Apple's operating system, they need to be marked with the '@objc' attribute

class Car {
    var model: String
    var color: String
    
    init(model: String, color: String) {
        self.model = model
        self.color = color
    }
    
    func drive() {
        print("wroom")
    }
}

class RaceCar: Car {
    var maxSpeed: Int
    
    init(model: String, color: String, maxSpeed: Int) {
        self.maxSpeed = maxSpeed
        super.init(model: model, color: color)
    }
    
    override func drive() {
        print("WROOOOOOM!")
    }
}





// Properties
// Structs and classes (collectively: 'types') can have variables and constants,called properties, they are used to attach vallues to those types.
// Property observers are used to run code when a property is about to change ('willSet') or just changed ('didSet'), Swift provides special values called 'newValue' for 'willSet', that contains what the new property value is going to be, and 'oldValue' for 'didSet', which represents to the previous value
// Computed properties are code blocks that act and can be used like properties, they use the 'get' or 'set' keywords to trigger actions for when they're set or read. If they're only used for reading date the 'get' keyword can be omitted

struct Phone {
    var name: String {  // Property example
        willSet {       // Property observer example
            print("I'm thinking about switching to an \(newValue)")
        }
        didSet {        // Property observer example
            print("I switched to an \(name)")
        }
    }
    var year: Int {
        didSet {
            print("This phone is from \(year)")
        }
    }
    var age: Int {
        get {           // Computed propery example (read -> get)
            return 2020 - year
        }
        set {           // Computed propery example (write -> set)
            year = 2020 - newValue
        }
    }
    var isGreat: Bool { // Computed propery example (read only, get omitted)
        if name == "iPhone" {
            return true
        } else {
            return false
        }
    }
    
    func describe() {
        print("This is a \(name) phone from \(year), it's \(age) years old\(isGreat ? ", it's a great phone!" : ".")")
    }
}

var phone = Phone(name: "Android", year: 2016)
phone.describe()
phone.age
phone.name = "iPhone"
phone.age = 0
phone.describe()



// Static properties and methods
// are properties and methods that belong to the type rather than the instance of that type, that means they're shared across all instances of that type
// a good example would be a counter for how many instances of that type were created
// to create a static property or method, the 'static' keyword is used

struct MetalFan {
    static var moshPitCounter: Int = 0
    var favoriteBand: String
    
    init(favoriteBand: String) {
        self.favoriteBand = favoriteBand
        MetalFan.moshPitCounter += 1
    }
}
let fan = MetalFan(favoriteBand: "Metallica")
for _ in 1..<10 {
    let _ = MetalFan(favoriteBand: "Metallica")
}
print("\(MetalFan.moshPitCounter) Metal fans are here")



// Access control
// is used to specify what data from inside structs and classes should be exposed to the outside, there are four modifieres
// - 'public', everyone can access the property
// - 'internal', only your Swift code can access the property
// - 'fileprivate', only Swift code in the same file can access the property
// - 'private', only methods or extensions of the type can access the property

struct GateKeeper {
    public var name: String = "Otto"                    // everyone can see his name
    internal var rank: Int = 2                          // only collegues know his rank
    fileprivate var coffeeMugColor: String = "White"    // only visible from inside his booth
    private var salary: Int = 3000                      // only he knows
}



// Polymorphism and typecasting
// Polymorphism means that an instance of a Type that inherited from a parent class can be treated as both its own type or the parents type
// Child classes can override parents methods if needed, or just use them as is
// Typecasting is used to convert an object of one type to another, for example when looping over an array filled with instances of parent and hild classes it might be useful to cast an item to the correct child class to use a method or property that only that type has
// Swift has three forms of typecasting:
// - optional downcasting with 'as?', which tries to convert if possible and assigns 'nil' if not, this is most commonly used with 'if let' or 'guard let'
// - forced downcasting with 'as!', which tries to convert if possible or crashes the code if not
// - the type check operator 'is' can be used in conditions to check if an instance is of a certain type
// Common types (String, Int, Bool, Double) can oftentimes be converted to a different type using that types initializer, e.g. 'let text = String(5)'

class Album {
    var name: String
    init(name: String) {
        self.name = name
    }
    func getPerformance() -> String {
        return "The Album \(name) sold lots"
    }
}
class StudioAlbum: Album {
    var studio: String
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}
class LiveAlbum: Album {
    var location: String
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")
var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]
// array containing 3 different types, Album, StudioAlbum and LiveAlbum

for album in allAlbums {
    print(album.getPerformance())
    
    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
}



// Closures
// can be thought of as variables that hold code that also 'captures' its environment, meaning they take a copy of the values that are used inside them
// They're most often used as arguments to functions so that they can store code to execute later
// when used as the last parameter in a function it is possible to call the function using the 'trailing closure' syntax

func specialGreeting(name: String, special: () -> Void) {
    print("Hello \(name), you got a special greeting:")
    special()
}

specialGreeting(name: "OddMagnet") {
    print("This is a trailing closure greeting!")
}
