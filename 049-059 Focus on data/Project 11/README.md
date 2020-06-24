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
- aside from `\.presentationMode` the environment contains many more properties, like `\.horizontalSizeClass` and `\.verticalSizeClass`
- both of those properties can be either `.compact` or `.regular` and tell us about the currently available screen space
- this is useful for example when using multi-tasking on the iPad
- sometimes a different View should be showed depending on the size class, but returning two different views in a body is not possible
- to accomplish this, **type erasure** can be used, which is done by simple wrapping the view in `return AnyView( /* View here */ )`
- `AnyView` does not expose what it contains externally, which makes it possible to return different views
- this comes with the downside of SwiftUI not being able to only re.render small parts of the UI

## How to combine Core Data and SwiftUI
-

## Wrap up - Challenges
- 
