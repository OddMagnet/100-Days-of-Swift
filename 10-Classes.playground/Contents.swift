import UIKit

// Creating your own classes
// classes are similiar to structs, but have a five important differences
// the first one being that classes don't have a default initializer

class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
// classes always need a custom initializer
let poppy = Dog(name: "Poppy", breed: "Poodle")



// Class inheritance
// the second difference is that classes can be based on an existing class
// this is called 'inheritance' because the new class inherits all the
// properties and methods of the original class and can add its own on top
// the class that is being inherited from is called the 'parent' or 'super' class
// and the new class is called the 'child' class

class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}
// this class inherits from the 'Dog' class
// the 'super' keyword is used to call the initializer of the parent class
// the call to 'super.init()' is always needed



// Overriding methods
// child classes can replace parent methods with their own implementations
// this process is known as 'overriding'

class Cat {
    func makeNoise() {
        print("Meow!")
    }
}
let kitty = Cat()
kitty.makeNoise()

class Lion: Cat {
    override func makeNoise() {
        print("ROAR!")
    }
}
let simba = Lion()
simba.makeNoise()



// Final classes
// with the 'final' keyword it is possible to stop other classes
// to inherit from a class, so methods can't be overridden

final class Turtle {
    var name: String
    var color: String
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
}
// this class can't be inherited from



// Copying objects
// the third difference lies in how they are copied
// When copying a struct, both the original and copy are different things,
// so changing one won't change the other
// When copying a class, both the original and copy point to the same thing,
// so changing one does also change the other

class Singer {
    var name = "Taylor Swift"
}
var singer = Singer()
print(singer.name)
var singerCopy = singer
singerCopy.name = "Billie Eilish"
print(singer.name)
// even though the name of 'singerCopy' was changed, it also affected 'singer'



// Deinitializers
// the fourth difference is that classes can have deinitializers
// that is, code that gets run when an instance of a class is destroyed

class Person {
    var name = "John Doe"
    
    init() {
        print("\(name) is alive!")
    }
    
    deinit {
        print("\(name) is no more!")
    }
    
    func printGreeting() {
        print("Hello, I'm \(name)")
    }
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}
// each time the loop goes around, the old person constant will be destroyed



// Mutability
// the fifth and final difference is the way they deal with constants
// a variable property in a constant struct can't be changed
// because the struct itself is constant
// a variable property in a constant class however can be changed
// because of this classes don't need the 'mutating' keyword

let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)
// even though the class is created as a constant, the property can be changed



// Classes summary
// are similiar to structs, they both can create custom types
// with custom properties and methods, but have 5 important differences
// 1) classes don't have a default initializer
// 2) classes can inherit from another class
// 3) changing a copy of a class object changes the original too
// 4) classes can have deinitializers
// 5) a variable property can't be changed in a constant struct, but in a class it can
// classes can be marked as final
// method overriding lets a child have a different implementation for a method than its parent
