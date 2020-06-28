# 100 Days of Swift - Day 60 to 61 - Consolidation V
Consolidation/Review of Days 49 to 59, notes in this readme, challenge completed in the project

![App screenshot](App1.png) ![App screenshot](App2.png) ![App screenshot](App3.png)


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


## Challenge

