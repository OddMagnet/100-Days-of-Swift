import UIKit

// For loops
// are the most common loops in swift
// they loop over arrays and ranges, 'pulling' out one item each round
// and assign it to a constant

let albums = ["Red", "1989", "Reputation"]
for album in albums {
    print(album)
}

print("Players gonna ")
for _ in 1...5 {
    print("play")
}
// if the constant isn't needed an underscore can be used



// While loops
// are given a condition and will run while that condition is true

var number = 1
while number <= 10 {
    print(number)
    number += 1
}



// Repeat loops
// is identical to the while loop, but with the condition at the end
// it will always be executed at least once

repeat {
    print(number)
    number += 1
} while number <= 20

repeat {
    print("This is false")
} while false
// even though the condition is not true, the loop is run once



// Exiting Loops
// the 'break' keyword can be used to exit a loop at any time

var countDown = 10
while countDown >= 0 {
    print(countDown)
    
    if countDown == 4 {
        print("I'm bored. Let's go now!")
        break
    }
    
    countDown -= 1
}



// Exiting multiple loops
// a loop in a loop is called a nested loop
// to break out of multiple loops the 'break' keyword can be used with a label

outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("\(i) * \(j) is \(product)")
        
        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}
// the outer loop has a label, which is used on the break in the inner loop



// Skipping items
// to skip the current item in a loop, the 'continue' keyword is used

for i in 1...10 {
    if i % 2 == 1 {
        continue
    }
    print(i)
}
// skips all odd numbers



// Infinite loops
// are loops that have no end in their initial condition
// they only end because of an internal condition

var counter = 0

while true {
    print("This loop does not end")
    counter += 1
    
    if counter == 7 {
        break
    }
}
// without the 'break' the loop would go on forever



// Looping summary
// loops repeat code until a condition is false
// for loops assign each item inside the loop to a temporary constant
// that constant can be skipped by using an underscore '_'
// while loops run whil their condition is true
// repeat loops are similiar, but always run once, they check their condition at the end
// the 'break' keyword can be used to break out of a loop
// to skip items the 'continue' keyword is used
// infinite loops only end when broken from inside. they are made using 'while true'
