# iExpense 
An expense tracking app that seperates personal costs from business costs

![App screenshot](iExpense.png)


## Why @State only works with structs
- when a property in a **struct** changes, the whole struct changes, causing the SwiftUI to update the UI
- this is not the case for **classes**, so SwiftUI doesn't update the UI when a property in a class changes
- since structs always have unique owners, sending a struct to two views will actually give each view a unique copy
- this means, if one changes, the other won't, which is bad for sharing state
- sending a class to two views will have both of them point to the same data, but won't reflect changes in state
- to share data between views **@ObservedObject** can be used

## Sharing SwiftUI state with @ObservedObject
- to share data between two views a class and either **@ObservedObject** or @EnvironmentObject are needed
- for now, and in this project, the focus will be on @ObservedObject
- to make use of @ObservedObject, the properties that should be watched by SwiftUI need to be marked with **@Published**
- additionally the class needs to conform to the **ObservableObject** protocol
- the state variable in the view then simply uses **@ObservedObject** instead of @State

    ``` swift
    class User: ObservableObject {
        @Published var firstName = "Odd"
        @Published var lastName = "Magnet"    
    }
    struct ContentView: View {
        @ObservedObject var user = User()
        ...
    }
    ```

## Showing and hiding views
- one of the most basic ways of showing a view in SwiftUI are **Sheets**
- they present a new view on top of the existing one in a card-like presentation
- similiar to __Alerts__ they work based on conditions, which determine if they are presented or dismissed
- to show a new view in a sheet, a state variable is needed to track whether or not the sheet is showing, usually that is a boolean
- like alerts a modifier is used to attach the sheet to the view hierachy: `.sheet(isPresented:)`
- lastly, the sheet needs to contain a view to show when it's being presented
- to dismiss a sheet view programmatically (e.g. when user pressed a button), **@Environment** can be used
- it allows for creation of properties that store provided values externally, e.g. light/dark mode, font size, timezone
- to make use of this `@Environment(\.presentationMode) var presentationMode` needs to be added to the view that is displayed in a sheet
- to dismiss the sheet, `self.presentationMode.wrappedValue.dismiss()` is called
- __wrappedValue__ is needed since __presentationMode__ is actually a binding, so it can be updated automatically by the system

## Deleting items using onDelete()
- the `.onDelete()` modifier is used to control how objects are deleted from collections, it is mostly used with **List** and **ForEach**
- attaching `.onDelete()` also enables the user to remove rows from a list for example
- it can only be used on **ForEach**, which means a bit more code, but also makes it easy to create lists where only some rows can be deleted
- to use `.onDelete()` a method needs to be implemented that receives a single parameter of type `IndexSet`, holding the positions of items that should be removed
- if the list was created from a single array, the `remove(atOffsets:)` method of the array can be used
- to allow the user to delete several rows at once, simply adding a `EditButton()` to the navigationbar is enough

## Storing user settings with UserDefaults
- **UserDefaults** allows for storing a small amount of data that is loaded automatically when the app is launched
- it should be used to store user settings and other important data
- to store a value, `UserDefaults.standard.set(value, forKey: "Key")` is used
- __standard__ is the built-in instanceof UserDefaults, but it is also possible to create custom instances (e.g. for sharing between apps)
- the `set()` method accepts any kind of data
- the `forKey:` parameter is used to uniquely identify a value, so it can be loaded later on
- to load a value, `@State private var value = UserDefaults.standard.type(forKey: "Key")` is used, where `type` is the type of the data

## Archiving Swift objects with Codable
- in order to save more complex custom data types with Codable, they must conform to the **Codable** protocol
- to convert data the `encode()` method of **JSONEncoder** is used, it takes data that conforms to codable and sends back an object in 'Javascript Object Notation'
- since the encoding might throw errors it needs to be called with `try` or `try?`
- while Codable doesn't require the use of JSON, it is by far the most common format
- after converting the data, it can be saved, for example to the UserDefaults
- to decode data, the `decode()` method of **JSONDecoder** is used, which takes the target type and the data from which to decode from

    ``` swift
    Button("Save User") {
        let encoder = JSONEncoder()

        if let data = try? encoder.encode(self.user) {
            UserDefaults.standard.set(data, forKey: "UserData")
        }
    }
    Button("Load User") {
        let decoder = JSONDecoder()

        let data = UserDefaults.standard.data(forKey: "UserData")
        let decoded = try? decoder.decode(User.self, from data!)
    }
    ```

## Working with Identifiable items in SwiftUI
- in dynamic views, like Lists and ForEach, SwiftUI needs to be able to identify each item uniquely so it can compare view hierachies
- that means, when using arrays, there needs to be a value that is certain to be unique, so it can be used to identy the items
- for this, Swift offers **UUID**, 'universally unique identifiers', long hexadecimal strings
- to use this, the class/struct should conform to the **Identifiable** protocol and implement an id variable: `let id = UUID()`
- while the protocol is not strictly necessary, it removes the need to tell ForEach which property it should use as the identifier

## Wrap up - Challenges
- 
