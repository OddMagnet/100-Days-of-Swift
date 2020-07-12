# 100 Days of Swift - Day 77 to 78 - Consolidation V
Consolidation/Review of Days 62 to 76, notes in this readme, challenge completed in the project

![App screenshot](APPNAME1.png) ![App screenshot](APPNAME2.png) ![App screenshot](APPNAME3.png)


## What I learned
- how property wrappers work behind the scenes
- custom bindings
- **action sheets**
- **Core Image**
- integrating UIViews, namely **UIImagePickerController** and **MKMapView**
- writing **coordinator** classes for UIViews
- using above mentioned views
- adding **Comparable** conformance to custom types
- using the documents directory, enabling encryption when writing and biometric authentication

## Key points
### Operator overloading
Naming a method the same as an operator (<, >, *, +, ...) is called **operator overloading**.
It's mostly used to give custom types access to common operators and in extensions to basic types.
A good example would be `func < (lhs: Self, rhs: Self) -> Bool { ... }` in a custom type, to enable conformance to `Comparable`.
Operator overloading should be used sensibly. If the meaning of a line of code becomes unclear because of an overloaded operator,
then overloading was likely the wrong solution.

### Custom property wrappers
**Propery Wrappers** are a value, that is being wrapped by another value to add extra functionality.
It's possible to create custom wrappers by creating a struct which is preceeded by `@propertyWrapper`

```swift
@propertyWrapper
struct NonNegative<Value: BinaryInteger> {
    var value: Value

    init(wrappedValue: Value) {
        if wrappedValue < 0 {
            self.value = 0
        } else {
            self.value = wrappedValue
        }
    }

    /* getters and setters omitted */
}
```


## Challenge

