# 100 Days of Swift - Day 95 - Consolidation VII
Consolidation/Review of Days 79 to 94, notes in this readme, challenge completed in the project

![App screenshot](APP1.png) ![App screenshot](APP2.png) ![App screenshot](APP3.png)


## What I learned
- using the environment with **@EnvironmentObject**
- **TabView**
- using Swifts **Result** type
- manually publishing changes in an __ObservableObject__
- controlling image interpolation
- **ContextMenu**
- creating local notifications
- adding and using package dependencies
- using **map()** and **filter()**
- creating and using QR codes
- creating and using custom gestures
- haptic feedback
- disabling user interactivity
- using **Timer** to trigger events and receive events from **NotificationCenter**
- many accessibility features
- SwiftUI's 3-Step layout system
- alignment, custom alignment guides, absolute positioning
- using **GeometryReader** and its proxy object to create special effects

## Key points
### Functional programming
Functional programming differs from imperative programming in that instead of __how__ something should happen the focus is on __what__ should happen.
To filter a list of numbers for some condition, in imperative programming a loop would be used, a condition would be checked and matching elements added to a result array.
In functional programming it's possible to simply use a higher order function - a function that takes a closure - to do the same job.
To accomplish the same task the `filter()` function can be used on the array and simply be given a closure with the condition to use on the numbers.
This has a few advantages, the function will always process every element in the array, there are no __break__ conditions, it's possible to use a shared function instead of a closure and the resulting array is constant, so it can't be modified by accident.
Aside from being shorter code it's also simpler and has higher reusability.
Some ohter higher order functions in Swift are `map()` and `compactMap()` which both run a transformation on every element in an array, but `compactMap()` will also unwrap any optionals and discard any `nil` values, this is very useful to create an array with no optionals from one that has optional values.

### Result
Swifts **Result** type can be thought of as an advanced form of **Optionals**, they both are based on enums, but **Result** just is one value or another instead of a value or none.
**Optional** has the cases `.none` for nil and `.some` with an associated value for whatever type the optional is.
**Result** has two cases with associated values, `.success` and `.failure`.
The biggest difference is the syntactic sugar that Swift has for optionals, creating them by simply adding a `?` to the variable type and using `if let` and optional chaining.
It's possible to use **Result** and throwing functions interchangebly by simply using the `get()` method of the result, which will throw an error if the success value doesn't exist.
The other way around is also possible, **Result** offers an initializer that accepts a throwing closure, thus creating a result variable that either has a `.success` state with some value or an `.failure` state with the error that was thrown.
`let result = Result { try String(contentsOf: someURL) }` would result in a `Result<String, Error>` type variable.

## Challenge
- 
