# Drawing
A technique project focused on drawing custom paths and shapes in SwiftUI and animate them

![App screenshot](Drawing.png)


## Creating custom paths with SwiftUI
- like most other things in SwiftUI, **Path** is also a view
- the path view accepts a closure that needs a single parameter, the path that will be drawn into
- inside the closure methods can be called on the path
- `move(to:)` is used to set the starting point and `addLine(to:)` draws a line from the last point to the specified point
- to scale a path based on device size, **GeometryReader** can be used
- a few modifiers that can be used on the path view are `.fill()` to fill the inside of the path and `.stroke(,lineWidth:)` to color the path lines
- the stroke modifier can also be used with a style parameter: `.stroke(Color.blue, style: StrokeStyle(...))`
- `StrokeStyle()` can be used to set things such as lineWidth, lineCap and lineJoin

## Paths vs Shapes
- a path is a series of drawing instructions whereas a shape is built using paths and is drawn relative to the rectangle it is in
- SwiftUI has a **Shape** protocol that requires a single method `path(in rect:)` that is given a rectangle and returns a path that will be drawn in the rectangle
- the rectangle allows for access to properties such as `rect.minX`, `rect.maxX`, `rect.minY` and `rect.maxY`
- after creating a shape struct, it can be drawn by simply using it as a View and using the `frame(width:, height:)` modifier on it
- in summary, the key difference is reusability, paths do one specific thing while shapes are flexible in terms of their drawing space

## Wrap up - Challenges
- 
