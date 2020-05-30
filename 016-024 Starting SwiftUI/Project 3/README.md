# ViewsAndModifiers

This is a technique project to explore certain SwiftUI features, namely **Views** and **modifiers**  in detail

![App screenshot](ViewsAndModifiers.png)


## Why structs for views
- **Performance**, structs are simpler and faster than classes
- in __UIKit__ every class and subclass has many properties and methods, but they're not needed in every class
- a struct will always only be the size of what it actually contains, while a class often is much bigger because of inheritance
- **Functional design**, views depends on state, having to isolate state cleanly means less messy code

## What's behind the main SwiftUI view
- nothing. would be the short and simple answer
- technically **UIHostingController** is behind it, as a bridge to **UIKit**
- this should not be attempted to be modified, instead the main view should just be treated as there is nothing behind it
- with this mindset, modifiers like `.background()` make more sense, they only fill the background of their element, not the whole screen

## Why modifier order matters
- applying a modifier to a view creates a new view, which is why the modifier order matters
- using `.background()` first and then `.frame()` won't fill the size of the frame, but it will when order is reversed
- this can be explored in greater detail by using `type(of: self.body)` which will return the exact type of the current view
- e.g. `ModifiedContent<ModifiedContent<Button<Text>, _BackgroundModifier<Color>>, _Frameleyout>`, a button with text inside, modified by `.background()` and then `.frame()`
- these modifiers are best read from the innermost type outward, in this example that would be `ModifiedContent<Button<Text>, _BackgroundModifier<Color>>`
- the outer type would be `ModifiedContent<..., _FrameLayout>`

## Why __some view__ for the view type
- SwiftUI relies heavily on a feature called __opaque return types__
- **some View** is one of them, it means that one specific type that conforms to the **View** protocol will be returned
- but it must be always the same type of view, else Swift would not be able to correctly update the UI
- this also explains why SwiftUI can only stack up to 10 views in a stack
- since the view type must always be the same, the 'stack-views' use **TupleView** under the hood
- that means there exist __TupleViews__ from containing only 2 views up to 10 views

## Conditional modifiers
- a common use of the ternary operator is to apply different modifiers based on a condition, e.g. make a button red or green
- this is often used like this: `.modifier(condition ? option1 : option2)`
- most of the time the condition is a state variable
- it's also possible to use if condition to return the same view type but with (or without) different modifiers

## Environment modifiers
- modifiers applied to a container, e.g. a `VStack`, are called environment modifiers
- they are used just like regular modifiers, but affect all child views
- the same modifier applied to a child view overrides the environment modifer and takes priority

## Views as properties
- it's possible to create views as properties, e.g. `let someText = Text("Hello World!")`
- this is useful to avoid repition and move complex code out of the `body` property
- views stores as properties can't refer to other stored properties, but it's possible to create computed properties with views

## View composition
- it's possible to break complext views down into smaller views, with little to no performance impact
- for example, if many views use the same modifiers (e.g. styled text views), it would be useful to create a custom view representing this specific type of view
- custom views are just structs that implement the `View` protocol and can be used like any other view, e.g. adding modifiers to them

## Custom modifiers
- just like custom views it's also possible to create custom modifiers, by creating a struct that implements the `ViewModifier` protocol
- to use custom modifiers the `.modifier()` modifier is used, with the custom modifier as the argument
- alternatively the it's possible to use an extension on `View` to add the custom modifier as a function

## Custom containers
- it's possible to create custom containers that can accept and hold any type of view
- for this __generics__ are used, `struct GridStack<Content: View>: View {...}` 
- `Content: View` means that it can accept anything that conforms to the `View` protocol
- the following `: View` means that __GridStack__ itself conforms to the `View` protocol
