# Drawing
A technique project focused on drawing custom paths and shapes in SwiftUI and animate them

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

## Adding strokeBorder() support with InsettableShape
- the difference between `.stroke()` and `.strokeBorder()` is that stroke draws on the line, while strokeBorder draws inside of it
- to add support for `strokeBorder()` to a custom shape, it needs to conform to the **InsettableShape** protocol
- it needs variable for the inset and the `path(in rect:)` method needs to use the inset
- the required `inset(by amount:)` is then used to set the inset variable
- once all requirements are fullfilled, `.strokeBorder()` can be called on the custom shape

## Transforming shapes using CGAffineTransforms
- **CGAffineTransform** describes how a path or view is rotated, scaled or sheared
- different from shapes which mostly use degrees, CGAffineTransform uses radians
- it's important to remember that the order of operations matters
- to apply the transformations to a path, it's best to first create them as variables, then use them on the path
- to create a transformation `CGAffineTransform(...)` is used, with whatever parameters are needed for the transformation
- to append another transformation `transform2 = transform1.concatenating(CGAffineTransform(...))` is used
- using the `.applying()` method of a path will apply the transformation to it

## Filling paths using even-odd
- it's possible to add multiple paths to a 'main-path'
- when filling that main-path, all paths get filled
- to only fill each second path, `FillStyle()` can be used as a parameter for the `fill()` modifier 

## Creative borders and fills using ImagePaint
- while Color can be used as a view, but also in shapes, Image can not
- this is because of the protocols the types conform to, Color conforms to `ShapeStyle` while Image does not
- it's possible to use an image in a shape with `ImagePaint(image:, scale:)`
- aside from the self-explanatory parameters in the example above, it's also possible to use the `sourceRect` parameter
- `sourceRect` expects a CGRect where `x` and `y` are the starting points and `width` and `height`have a value between 0 and 1
- 0 would be the 'start' of the image and 1 would be the 'end' of it

## Enabling high performance Metal rendering with drawingGroup()
- in Core Animation the FPS might drop below 60 (120 for newer devices) for complex renders, in that case **Metal** should be used 
- this can be achieved by simply `.drawingGroup()` modifier on the view containing the complex render
- SwiftUI will then render the contents of the view into an off-screen image with Metal, before putting it back onto the screen

## Special eddects in SwiftUI
- SwiftUI has a lot of modifiers who control rendering, a few of them are `.blendMode()`, `.saturation()` and `blur()`
- depening on the mode passed to the `.blendMode()` modifier it will change how overlayed views interact
- by default they just 'paint over' the other view, e.g. `.multiply` multiplies the pixel colors of the overlaying views
- since it's so common to multiply with a simple color SwiftUI also offer the `.colorMultiply()` modifier, so no extra Color views need to be created
- passing `.screen` to the `.blendMode()` modifier will invert the colors, multiply and invert again, basically a `.multiply` but lighter
- both `.blur()` and `.saturation()` are quite self explanatory, they take a value between 0 and 1 where 0 is blurred / unsaturared and 1 is unblurred / saturated

## Animating simple shapes with animatableData
- to animate a simple shape, they need a computed property `var animatableData: CGFloat { /* getter and setter here */ }`
- inside the closure, there need to be getter and setter for the property that should be animated on change
- finally there the actual change of the property must be wrapped with `withAnimation { /* property change here */  }`
- this is however limited to one value being changed

## Animating complex shapes with AnimatablePair
- to animate multiple changing properties, the `AnimatablePair<First, Second>` protocol is used
- the shape struct then again needs the `animatableData` computed property, but this time it needs to be marked public and use `AnimatablePair`
- e.g. `public var animatableData: AnimatablePair<First, Second> { /* getter and setter here */ }`
- to use more than 2 properties another AnimatablePair is needed: `AnimatablePair<First, AnimatablePair<First, Second>>`
- this can be repeated as often as necessary, though accessing values becomes less straight forward the more properties need to be animated

## Bonus - Spirograph
just a nice little animation, no real notes here since no new things (in terms of programming) were learned

## Wrap up - Challenges
- create an arrow shape from a rectangle and triangle
- make line thickness of the arrow animatable
- create a ColorCyclingRectangle with control of the gradient position
