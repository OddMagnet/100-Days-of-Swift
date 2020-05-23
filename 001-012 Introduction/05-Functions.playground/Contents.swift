import UIKit

// Writing functions
// enables the re-use of code
// functions start with the 'func' keyword, then the function name,
// followed by open and close parentheses
// The body (code) of the function is placed inside brace

func printLorem() {
    let message = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
"""
    
    print(message)
}

printLorem()
// this calls (runs) the function



// Accepting parameters
// Values sent into functions are called parameters
// Too accept parameters they must be given a name,
// followed by a colon and their type
// all this is placed inside the parentheses after the function name

func squarePrint(number: Int) {
    print(number * number)
}
// receives an integer and squares it

squarePrint(number: 8)



// Returning values
// to write a function that returns a value a '->' is added after the
// functions parameter list and the 'return' keyword is used inside the
// functions block
// After the function returns a value, no other code is run

func square(number: Int) -> Int {
    return number * number
}

let result = square(number: 4)
print(result)



// Parameter labels
// Swift allows for 2 names for each parameter
// the first  is the external name, the second the internal name
// this allows for sensible names inside and outside of functions
// and also for functions to read more naturally

func sayHello(to name: String) {
    print("Hello, \(name)!")
}

sayHello(to: "Taylor")



// Omitting parameter labels
// it's possible to omit the external parameter names by using an underscore
// this should only be used if it makes the code more natural to read

func greet(_ person: String) {
    print("Hello, \(person)!")
}

greet("Taylor")



// Default parameters
// it's possible to add a default value to function parameters
// by writing an '=' after the parameter type, followed by the value

func greet(_ person: String, nicely: Bool = true) {
    if nicely {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

greet("Taylor")
greet("Justin", nicely: false)
// parameters with default values can be omitted when calling the function



// Variadic functions
// can accept any number of parameters of the same type
// to make a parameter variadic add '...' after the parameter type
// inside the function the values passed are converted to an array

func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

square(numbers: 1, 2, 3, 4, 5)



// Writing throwing functions
// when a function fails it's useful to be able to throw an error
// for that the function needs to marked by the 'throw' keyword
// which is placed after the parameter list and before the return type

enum PasswordError: Error {
    case obvious
}
// to be able to throw an error, an enum based on Swifts Error type is needed
// this is used to describe the error that can be thrown

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}
// this function throws an error on "password"



// Running throwing functions
// when calling a function that can throw an error, it needs to be
// wrapped in a 'do catch' block and the function call must be
// preceeded by the 'try' keyword
// the 'do' block contains the function that can potentially throw an error
// while the 'catch' block handles the error when it's thrown

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}



// Inout parameters
// generally parameters passed to a function are consts and can't be changed
// to change a parameter inside a function it must be marked using the 'inout'
// keyword before the parameter type and the parameter passed must have an
// ampersand '&' before its name, which is an explicit recognition of the
// awareness that it's used as 'inout'

func doubleInPlace(_ number: inout Int) {
    number *= 2
}

var varNum = 10
let constNum = 20

doubleInPlace(&varNum)
//doubleInPlace(&constNum)
// it's only possible to pass variable for an 'inout' paremeter
// using a constant would stop the code from compiling



// Functions summary
// Functions are used to re-use code without repeating it
// they can accept parameters and return values
// both parameter and return value types must be specified
// It's possible to specify different names for parameters externally
// and internally or omit the external name entirely
// Parameters can have default values
// Variadic functions accept zero or more of a specific parameter
// and Swift converts the input into an array for use inside the function
// Functions can throw errors, those functions must then be called using 'try'
// and must be placed inside a 'do' block, followed by a 'catch' block
// which handles errors that might be thrown
// It's possible to change variables inside a function using 'inout'
// but in general it's usually better to return a new value
