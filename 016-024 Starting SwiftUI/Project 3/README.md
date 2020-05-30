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
- 

## Conditional modifiers

## Environment modifiers

## Views as properties

## View composition

## Custom modifiers

## Custom containers

