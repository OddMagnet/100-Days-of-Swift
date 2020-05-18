import UIKit

// Arithmetic Operators
// are symbols like plus '+', minus '-', multiply '*' and divide '/'
// Swift also has a modulo operator '%'

let firstScore = 12
let secondScore = 4
let total = firstScore + secondScore
let difference = firstScore - secondScore
let product = firstScore * secondScore
let divided = firstScore / secondScore
// all the basic mathematical symbols

let remainder = 13 % secondScore
// modulo '%' is the remainder, 4 fits 3 times into 13, 1 remains



// Operator overloading
// means that what the operator does depends on the values it is used on

let result = 2 + 2
let fullName = "Taylor" + "Swift"
let beatles = ["John", "Paul"] + ["George", "Ringo"]
// '+' for example can be addition, joining strings or even joining arrays



// Compoung assignment operators
// are shorthands for changing a variable in place with an operator

var score = 95
score -= 5
var quote = "The rain in Spain falls mainly on the "
quote += "Spaniards"
// to use them, add an equal '=' after the operator



// Comparison operators
// are operators used to perform a comparison
// 2 operators check for equality
// 4 operators to check if one value is
// greater than '>', less than '<', greater or equal '>=' and less or equal '<='

firstScore == secondScore
firstScore != secondScore
// '==' checks that two values are the same and '!=' checks that they are not the same

firstScore < secondScore
firstScore >= secondScore
// greater than '>', less than '<', greater or equal '>=' and less or equal '<='



// Conditions
// are written using 'if' statements
// if a given condition is true, then the code will be run
// it's possible to chain conditions by using 'else if'
// or to provide code for when no condition is met, using 'else'

let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 2 {
    print("Aces - lucky!")
} else if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}
// the code inside the '{' and '}' will be run if the condition is true
// if no condition is true the code after the 'else' will be run



// Combining conditions
// Swift has two special operators to combine conditions
// they can be used to chain more than one condition

let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}
// '&&' (and) to check that both conditions are true

if age1 > 18 || age2 > 18 {
    print("At least one is over 18")
}
// '||' (or) to check that at least one condition is true



// The ternary operator
// is an operator that works with three values at once
// the first value is a condition that it checks
// if the condition is true, it returns the second value
// if not, it returns the third value

print(firstCard == secondCard ? "Cards are the same" : "Cards are different")
// checks if cards are the same and then prints either the second or third value

if firstCard == secondCard {
    print("Cards are the same")
} else {
    print("Cards are different")
}
// the same could be accomplished using a regular condition



// Switch statements
// are used when there are multiple outcomes to a condition
// every case represents a possible outcome
// all possible cases must be covered, or the 'default' case must be used
// to continue execution on to the next case, the 'fallthrough' keyword is used

let weather = "sunny"

switch weather {
case "rain":
    print("(Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}
// if the weather is neither "rain" nor "snow" nor "sunny", the default case would be run



// Range operators
// there are 2 ways of creating a range
// '..<', the half-open range operator create a range up to but excluding the final value
// '...', the closed range operator creates a range up to and including the final value

let oneToFour = 0..<5   // excludes the final value
let oneToFive = 0...5   // includes the final value



// Operators and conditions summary
// Swift has operators for doing arithmetic and for comparison
// There are compound variants of the arithmetic operators to modify variables in place
// To run code based on the result of a condition, 'if', 'else if' and 'else' can be used
// The ternary operator combines a check with true and false code blocks
// Instead of multiple conditions 'switch' can be used
// Ranges can be created using '..<' and '...'
