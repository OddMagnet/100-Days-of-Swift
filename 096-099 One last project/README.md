# SnowSeeker
An app that lets the user browse ski resorts around the world.

![App screenshot](SnowSeeker.gif)


## Working with two side by side views in SwiftUI
- by default **NavigationView** is designed to work with two views rather than one
- this behaviour can be seen by putting a device (or simulator) in landscape mode
- if no secondary view is provided it will just show a blank screen
- by providing a secondary view it will show as:
    - the primary view on portrait iPhones
    - the secondary view on larger landscape iPhones, with the option to 'swipe in' the primary view from the leading edge
    - the secondary view on portrait iPads, with the option to 'swipe in' the primary view from the leading edge
    - both the primary and secondary view on landscape iPads
- for **NavigationLink** views SwiftUI automatically links the it (the primary view) to its destination (the secondary view)
- this means the primary view will automatically load its content in the secondary view
- currently there are a few drawbacks compared to UIKit
    - the initial secondary view isn't given a navigation bar, so setting a title does nothing
    - subsequent detail views (secondaries) always get a navigation bar whether wanted or not
    - it's not possible to make the primary view stay visible on portrait iPads
    - it's not possible to have a menu button in the navigation bar of the secondary view
    - it's not possible to make the primary view show by default in landscape, SwiftUI always chooses the detail view

## Using alert() and sheet() with optionals
- aside from using a binding to a Boolean it's also possible to use alerts and sheets with optional **Identifiable** objects
- by passing the alert/sheet modifier an optional item whose type conforms to the Identifiable protocol, the alert/sheet will show once it gets a value
- after dismissing the alert/sheet the variable gets set back to nil
- `@State private var selectedUser: User? = nil` where user conforms to `Identifiable`
- then `.alert(item: $selectedUser) { user in /*...*/ }` can be used
- inside the closure the variable can be used like any other non-optional variable

## Using groups as transparent layout containers
- when creating layouts for both portrait and landscape (or just smaller and bigger devices) often a change between vertical and horizontal layout is needed
- this is where **Group** views are practical, they act as a transparent layout container, meaning their children just adopt the layout of the stacks that surround it
- for example it's possible to do the following
```swift
Group {
    if layoutVertically {
        VStack {
            SomeGroupView()
        }
    } else {
        HStack {
            SomeGroupView()
        }            
    }
}
```
- depending on the condition `SomeGroupView`'s content will either show vertically or horizontally
- for the condition it's common to use size classes `@Environment(\.horizontalSizeClass) var sizeClass`

## Other
- to format an array of strings into a single string with natural wording, `ListFormatter.localizedString(byJoining:)` can be used

## Wrap up - Challenges
- add photo credit to the ResortView images
- add loading/saving for favorites
- add a sorting menu for the list of resorts in ContentView
