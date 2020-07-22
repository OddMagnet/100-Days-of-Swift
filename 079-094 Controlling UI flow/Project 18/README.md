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
- 

## Absolute positioning for SwiftUI views
- 

## Understanding frames and coordinates inside GeometryReader
- 

## ScrollView effects using GeometryReader
- 

## Wrap up - Challenges
- 
