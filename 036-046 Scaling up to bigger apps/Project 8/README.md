# Moonshot
An app detailing some of the history behind NASA's Apollo space program

![App screenshot](Moonshot.png)


## Resizing images using GeometryReader
- to resize images, a combination of the `resizable()`, `aspectRatio(contentMode:)` and `frame(width:, height:)` modifiers could be used
- often times what is needed is an image that will fir the width of the screen, rather than having a hard-coded size
- for this SwiftUI has a special type, called **GeometryReader**
- when using a GeometryReader view, the trailing closure gets passed a **GeometryProxy** object
- this object can be used to query the environment, e.g. 'how big is the container?', 'what position is the view?', 'are there safe area insets?' etc
- when inside a GeometryReader view, the `frame()` modifier can be used with only __width__ or __height__
- more in-depth learning about GeometryReader will be done in Project 15

## How ScrollView works with scrolling data
- both __List__ and __Form__ automatically create scrolling tables of data, but for views created by hand **ScrollView** is needed
- it allows for scrolling horizontally, vertically or both and it's possible to hide or show the scroll indicators
- different from __List__ and __Form__, **ScrollView** creates the views inside them immediately
- this is usually not a problem, but should be kept in mind when creating lots of 'heavy' views

## Pushing new views onto the stack using NavigationLink
- 

## Working with hierachical Codable data
- 

## Wrap up - Challenges
- 
