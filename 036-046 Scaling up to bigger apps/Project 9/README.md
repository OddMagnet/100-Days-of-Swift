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

## REPEAT_H2_FOR_EVERY_STEP
- 

## Wrap up - Challenges
- 
