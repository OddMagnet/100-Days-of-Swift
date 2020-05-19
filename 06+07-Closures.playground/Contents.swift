import UIKit

// Creating basic closures
// Functions can be used like any other type (e.g. strings, integers)
// this makes it possible to assign them to a variable, call the
// function using that variable and even pass the function to other
// functions as parameters.
// Functions used this way are called closures

let driving = {
    print("I'm driving in my closure")
}
// creates a nameless function and assigns it to the 'driving' variable



// Accepting parameters in a closure
// the parameters a closure can accept are listed inside the braces
// they are wrapped by parentheses and followed by the 'in' keyword
// so that Swift knows where the main body is starting

let drivingTo = { (place: String) in
    print("I'm going to \(place) in my closure")
}
// different from functions closures don't allow for parameter labels
drivingTo("London")



// Returning values from a closure
// to return values from a closure, the same syntax as in functions is used
// the '->' must be placed after the parameter list but before the 'in' keyword

let drivingWithReturn = { (place: String) -> String in
    return "I'm returning to \(place) with my closure"
}
let message = drivingWithReturn("London")
print(message)



// Closures as parameters
// since closures can be used like any other type, they can be passed into functions
// to create a function that takes a closures as a parameter the right parameter type
// has to be used '() -> Type' where 'Type' is the return type of the closure
// and the '()' just stands for the empty parameter list

func travel(action: () -> Void) {
    print("Ready to accept parameters.")
    action()
    print("Parameter executed!")
}

travel(action: driving)



// Trailing closure syntax
// Swift has a special syntax when the last parameter to a function is a closure,
// called 'trailing closure' syntax.
// Instead of passing a variable the closure was assigned to, it can be passed
// directly after the function inside braces

travel {
    print("I'm driving as a trailing closure!")
}
// using the above travel function with 'trailing closure' syntax
// since there are no other parameters the parentheses can be omitted



// Using closures as parameters when they accept parameters
// to use a closure that accepts parameters, simply fill the
// parameter list with the appropriate types

func travel(action: (String) -> Void) {
    print("Parameter is ready to accept a parameter.")
    action("London")
    print("Parameter-ception!")
}
// here the closure accepts one parameter of type 'String'

travel { (place: String) in
    print("I'm going to \(place) in my closure.")
}
// here the closure accepts one parameter of type 'String'



// Using closures as parameters when they return values
// to return values from a closure, simply change the
// return type from 'Void' to the appropriate type

func travel(action: (String) -> String) {
    print("Parameter is ready to return something")
    let description = action("London")
    print(description)
    print("Successfully returned")
}
// here the closure parameter has a return type

travel { (place: String) -> String in
    return "I'm going to \(place) in my closure"
}
// this closure returns a value of type 'String'



// Shorthand parameter names
// closures can be shortened quite a bit, here are some examples
// taking the closure given to the above 'travel' function
// to a minimum

travel { place -> String in
    return "I'm going to \(place) in my shorthand-closure 1"
}
// Swift knows the type of the parameter to the closure, so it can be omitted

travel { place in
    return "I'm going to \(place) in my shorthand-closure 2"
}
// Swift also knows the return type of the closure, so it can be omitted too

travel { place in
    "I'm going to \(place) in my shorthand-closure 3"
}
// If the closure only has one line of code, the 'return' keyword can be omitted

travel {
    "I'm going to \($0) in my shorthand-closure MAX"
}
// It's possible to let Swift provide automatic names for the closure parameters
// These are named with a '$' and then a number, starting from 0 counting up



// Closures with multiple parameters
// accepting multiple parameters in a closures parameter list works
// just like it would in a functions parameter list

func travel(action: (String, Int) -> String) {
    print("Ready to accept multiple parameters.")
    let description = action("London", 60)
    print(description)
    print("Successfully accepted multiple parameters")
}

travel {
    "I'm goint to \($0) at \($1) miles per hour."
}
// using 'trailing closure' syntax and shorthand closure parameters to call the function



// Returning closures from functions
// Functions can also return closures, just like they can accept them
// to return a closure the functions return type has to specify the
// closures parameter list and return type

func travel() -> (String) -> Void {
    return {
        print("Returned closure says: I'm going to \($0)")
    }
}
// this function returns a closure that accepts a string and does not return anything

let result = travel()
result("London")
// save the returned closure in a variable, then call it

//let result2 = travel()("London")
// technically it's allowedto call the return value from 'travel()' directly
// but it's not recommended and should be avoided



// Capturing values
// when external values are used inside a closured they get 'captured'
// that means they are stored alongside the closure and can be modiefied
// even if they don't exist any more

func travelWithCounter() -> (String) -> Void {
    var counter = 1
    
    return {
        print("I'm goint to \($0), my travel counter is: \(counter)")
        counter += 1
    }
}
// the closure returned by this function 'captures' the 'counter' variable

let resultWithCounter = travelWithCounter()
resultWithCounter("London")
resultWithCounter("New York")
resultWithCounter("Berlin")
// calling it the returned closure multiple times increases the counter
// showing that it was captured so that it remains alive for the closure



// Closures summary
// Closures can be assigned to variables and called later on
// they can accept parameters and return values, like regular functions
// they can be passed into functions as parameters
// if the last parameter to a function is a closure, 'trailing closure' syntax can be used
// Swift automatically provides shorthand parameter names for closures
// when external values are used inside a closure they will be 'captured'
