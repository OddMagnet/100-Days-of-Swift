# Bookworm
An app that tracks which books a user has read and his thoughts on them

![App screenshot](PROJECT_NAME.png)


## Creating a custom component with @Binding
- @State is used when working with local value types
- @ObservedObject when working with sharable reference types
- but what is used when creating custom views that change state in some other view, like `Picker`, `Stepper` etc?
- the answer to that is `@Binding`, it allows to create a mutable value in a view, that points to some other value elsewhere
- this makes it possible to have an `@State` property in the main-view and pass it to a child-view which can manipulate it

## Using size classes with AnyView type erasure
- 

## How to combine Core Data and SwiftUI
-

## Wrap up - Challenges
- 
