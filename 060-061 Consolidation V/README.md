# 100 Days of Swift - Day 60 to 61 - Consolidation V
Consolidation/Review of Days 49 to 59, notes in this readme, challenge completed in the project

![App screenshot](App1.png) ![App screenshot](App2.png) ![App screenshot](App3.png)


## Special Notes (REVISIT)
This project was a __insertSwearWordHere__. Up to adding Core Data everything was fine.
I tried for a few hours to make my Core Data entities conform to codable to no avail.
So I googled it, found a few articles and repos that implemented the articles code.
Instead of trying to replicate I just downloaded the projects and tried to run them.
None of them worked... So I tried implementing the articles myself.
Of course I couldn't get it to run either, maybe too tired..
Or maybe aiming for an 'elegant' solution isn't the way to go.
Checking if the managed object is empty and if so loading data into structs and then filling the managed object context is the way to go.
Maybe Core Data will get an update to work easier with Codable.
Maybe the next days will teach me something that helps to make this work.
But as long as that isn't the case I'll just aim for a working project.
And revisit this project in the future.

## What I learned
- custom **Codable** conformance
- sending and receiving with **URLSession**
- `disabled()` modifier
- building UI components with **@Bindable**
- type erasure with **AnyView**
- multiple buttons in alerts
- how **Hashable** works
- using Core Data with **@FetchRequest** wrapper
- sorting Core Data with **NSSortDescriptor**
- creating custom **NSManagedObject** subclasses
- filtering Core Data with **NSPredicate**
- creating relationships between entities in Core Data

## Key points
### AnyView vs Group: type erasure in practice
In SwiftUI `some View` is used since it's diffult to specify the precise type of a view when modified, and as long as the returned type stays the same it works great.
This has the downside that it's not possible to dynamically determine the type of the returned view, which makes it hard to conditionally return different views.
To solve this either `AnyView( /* view */ )` around every view  or `Group { /* views */ }` around the conditionals can be used.
While `Group` should in theory always be faster - since it doesn't hide information from SwiftUI - some considerations should be made:
- In practice there will be rarely performance problems with `AnyView`
- as long as performance is not an issue, the intent of the code should be more important, `Groups` are useful for:
    - breaking the 10-child limit for more complext layouts
    - delegating layout to a parent container, depending on if the `Group` view is embedded in an `VStack` or `HStack` it's layout will change
    - applying a set of modifiers to many views at once
- on the other hand, `AnyView` is only specifically used for type erasure
- when creating an array of Views with different types `Group` can't be used, so `[AnyView]` is the only option
- if used often an extension for view type erasure might be useful

    ``` swift
    extension View {
        func asAnyView() -> AnyView {
            AnyView(self)
        }
    }
    Text("Hello AnyView!")
        .asAnyView()
    ```

### Codable Keys
A few things not mentioned before on `Codable`:
- When the JSON uses a different naming convention, it's possible to just use the `keyDecodingStrategy` property of the decoder.
- `decoder.keyDecodingStrategy = .converFromSnakeCase` for example, after that the decoder will automatically decode the JSON from snake- to camel-case
- When the JSON uses different names for its properties, CodingKeys can help by adding raw value strings to their cases
- `case firstName = "first"` in the __CodingKeys__ enum would match the 'first' property of the JSON data to the 'firstName' property in the Swift code

## Challenge
Create an app that downloads JSON data, converts it to Swift types and displays it to the user
- fetch the data and parse it into `User` and `Friend` structs
- display a list of users with a bit of information about them
- create a detail view that presents more information about a tapped user
**Bonus**
- show a users friends on the detail screen
- show some information about the users friends on the detail screen
- make the friends tappable to show their detail view
