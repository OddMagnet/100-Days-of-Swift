# SnowSeeker
An app that lets the user browse ski resorts around the world.

![App screenshot](SnowSeeker.png)


## Working with two side by side views in SwiftUI
- by default **NavigationView** is designed to work with two views rather than one
- this behaviour can be seen by putting a device (or simulator) in landscape mode
- if no secondary view is provided it will just show a blank screen
- by providing a secondary view it will show as:
    - the primary view on portrait iPhones
    - the secondary view on larger landscape iPhones, with the option to 'swipe in' the primary view from the leading edge
    - the secondary view on portrait iPads, with the option to 'swipe in' the primary view from the leading edge
    - both the primary and secondary view on landscape iPads
- for **NavigationLink** views SwiftUI automatically links the it (the primary view) to its destination (the secondary view)
- this means the primary view will automatically load its content in the secondary view
- currently there are a few drawbacks compared to UIKit
    - the initial secondary view isn't given a navigation bar, so setting a title does nothing
    - subsequent detail views (secondaries) always get a navigation bar whether wanted or not
    - it's not possible to make the primary view stay visible on portrait iPads
    - it's not possible to have a menu button in the navigation bar of the secondary view
    - it's not possible to make the primary view show by default in landscape, SwiftUI always chooses the detail view

## Using alert() and sheet() with optionals
- 

## Using groups as transparent layout containers
- 

## Other notes
###Building a primary list of items
### Making a NavigationView work in landscape
### Creating a secondary view for NavigationView
### Changing a view's layout in response to size classes
### Binding an alert to an optional string
### Letting the user mark favorites

## Wrap up - Challenges
- 
