# Layout and geometry
A technique project to learn about how SwiftUI handles layout and geometry.

## How layout works in SwiftUI
- to make the layout happen, SwiftUI takes 3 simple steps
- A parent view proposes a size for its child
- The child chooses its own size
- The parent positions the child in itself
- technically a fourth step happens, the rounding of pixels to their nearest value, so graphics remain sharp
- for a good example, see `Layout.swift` in the project

## Alignment and alignment guides
- SwiftUI provides a number of ways to control how views are aligned
- `alignment` parameter of
    - a `.frame()` modifier simply specifies how the contained view is aligned
    - a stack view, like `HStack` and `VStack` specifies how its content is aligned
    - `HStack` also offers two special alignments, `.firstTextBaseline` and `.lastTextBaseline`, specifically to align text views
- it's also possible to provide a custom alignment for a single view via the `.alignmentGuide()` modifier
- this modifier takes two arguments, the guide that should be changed and a closure that returns the new alignment
- e.g. `.alignmentGuide(.leading) { d in d[.trailing] }` will cause a view to use it's trailing edge for the leading alignment guide
- the closure doesn't need to make use of the passed parameter, it's also possible to use external parameters and just return a value for the views position

```swift
ForEach(0 ..< 10) { position in
    Text("Number \(position)")
        .alignmentGuide(.leading) { _ in CGFloat(position) * - 10 }
}
```
- this will create 10 text views in a tiered effect

## How to create custom alignment guides
- to align views that are in different parts of the UI custom alignment guides are used
- to create a custom layout guide an extension on either `VerticalAlignment` or `HorizontalAlignment` and a custom type conforming to the `AlignmentID` protocol is needed
- the custom type is best implemented as an Enum, so it can't be instantiated
- to conform to `AlignmentID` a static `defaultValut(in:)` method needs to be implemented, which accepts a `ViewDimensions` object and returns a CGFloat
- the CGFloat specifies how a view should be aligned if it doesn't have an `alignmentGuide()` modifier
- for ease of use a static property can be added, so the custom alignment guide can be used like the standard ones: `static let customAlignment = VerticalAlignment(CustomAlignment.self)`
- by using the custom guide as the alignment for the containing view it's possible to align items in different container views via the `alignmentGuide()` modifier
- the modifier still needs its closure so it knows where on the line to align the items

```swift
HStack(alignment: .customAlignment) {
    VStack {
        Text("Some Line")
        Text("These lines")
            .alignmentGuide(.customAlignment) { d in d[VerticalAlignment.center] } 
    }

    VStack {
        Text("Are Aligned")
            .alignmentGuide(.customAlignment) { d in d[VerticalAlignment.center] }
        Text("Another Line")
    }
}
```

## Absolute positioning for SwiftUI views
- when using the `.position()` modifier for absolute position, a few things need to be kept in mind
- compared to `.offset()`, which does not change the actual geometry, `.position does`
- that means any modifiers applied before it will also change their position
- modifiers after it will take up all of the size the parent view provides
- this behaviour is directly related to how layout works in SwiftUI
- for `.offset`, modifiers before it will be moved, modifiers after it stay in the original position with the original siz layout works in SwiftUI
- for `.offset`, modifiers before it will be moved, modifiers after it stay in the original position with the original size

## Understanding frames and coordinates inside GeometryReader
- GeometryReader allows for determination of the size/coordinates of views, thanks to its own size that it gets by taking all the space its parent offers
- the property passed into GeometryReader is a `GeometryProxy` which contains from the parent proposed size, safe area insets that have been applied and a method for reading frame values
- the size can be accessed by simply using the proxy's `size` property (which contains `width` and `height` since they make up the size of a view)
- the `frame(in:)` method of the proxy allows for reading X and Y coordinates in regards to a certain **coordinate space**
- there are two special spaces, the `.global` (which refers to the whole screen) and the `.local` (which refers to the parents frame)
- it's possible to create a custom coordinate space by attaching the `coordinateSpace(name:)` modifier to a view, so any children of that view can read its frame relative to that space
- for a visual see the example in `FramesCoordinates.swift`
- to decide on which coordinate space to use:
    - to know where a view is on the screen -> global space
    - to know where a view is relative to its parent -> local space
    - to know where a view is relative to another view -> custom spaces

## ScrollView effects using GeometryReader
- thanks to GeometryReaders proxy object and it's `size` property and `frame(in:)` method its easy to create nice scrolling effects
- by wrapping the ScrollView in a GeometryReader it's possible to control the size of the elements inside the ScrollView
- by using a GeometryReader inside the ScrollView, its elements can be manipulated based on their position on the screen
- for a visual example see `ScrollViewEffects.swift`   

## Wrap up - Challenges
- 
