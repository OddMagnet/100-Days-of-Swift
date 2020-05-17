import UIKit

// Variables
// are places where program data is stored
// they are called variables because they can vary - their value van be changed freely

var str = "Hello, playground"
// This creates a new variables, named 'str' and gives it the value "Hello, playground"

str = "Goodbye"
// because 'str' is a variable, it can be changed
// the 'var' keyword is only needed to create a variable, not to change it



// Strings and integers
// since Swift is a type-safe language, each variable must be of one specific type
// the above 'str' variable is a String, since it contains a string of letters
// since strings and integers are different types, they can't be mixed
// that means it's not possible to assign a number to a String variable or
// assign a string to an Int variable

var age = 28
// this would be a variable of the Int type (short for integer), since it contains a number

var population = 8_000_000
// for large numbers it is possible to use underscores as seperators.
// they don't change the number, but make reading it easier



// Multi-line strings
// standard Swift strings use double quotes ("), but can't include line breaks
// it's possible to use line breaks in strings by using three double quotes

var multiStr1 = """
This goes
over multiple
lines
"""
// both the opening and ending of those multi-line Strings need to be on their own line

var multiStr2 = """
This goes \
over multiple \
lines
"""
// it's possible to 'escape' the line breaks with a backslash (\)
// this is useful if the multi-line string is only used to format the code neatly



// Doubles and booleans
// two other basic types in Swift are doubles and booleans
// double is short for 'double-precision floating-point number'
// doubles are used to hold fractional values, such as '3.141592654'
// booleans hold either 'true' or 'false'
// Swift automatically assigns the Boolean type to any variable that holds either 'true' or 'false'

var pi = 3.14
// doubles are different from integers and thus can't be mixed

var awesome = true
// an example of a boolean, simple but powerful



// String interpolation
// is the ability to place variables inside of strings
// it's possible to place any type of variable inside a string

var score = 85
var scoreStr = "Your score was \(score)"
// to use a variable in a string, a backslash followed by the variable in parentheses is needed

var results = "The rest results are here: \(scoreStr)"
// this can be repeated endlessly



// Constants
// the counterpart to variables, constants can only be set once and never changed again
// when trying to change a constant, Xcode will refuse to run the code
// when using a variable that never changes its value, Xcode  will warn about it
// when writing code it is prefered to use 'let' unless the value needs to be changed later on

let taylor = "swift"
// different from variables, constants use the 'let' keyword



// Type annotations
// Swift uses type inference, it infers the type of a variable based on how it was created
// it is also possible to be explicit about the type of the data

let album: String = "Reputation"
let year: Int = 1989
let height: Double = 1.78
let swiftRocks: Bool = true
// to explicitely assign the type, the variable or constant is followed by a colon,
// the type and then the assignment of the value



// Simple types: Summary
// variables are created by using 'var' and constants by using 'let'
// it's preferable to use constants whenever possible
// strings start and end with double quotes
// multi-line strings start and end with three sets of double quotes, each on their own line
// integers hold whole numbers, doubles hold fractional numbers and booleans hold true or false
// string interpolation allows for creation of strings from other variables and constants
// Swift uses type inference to assign types to variables and constants
// it is also possible to explicitely assign types
