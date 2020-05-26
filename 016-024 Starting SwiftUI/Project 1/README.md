# Wesplit
This project is a check-sharing app that calculates how to split a check based on the number of people and how much tip you want to leave.

## Basic SwiftUI app structure
### Xcode
- **AppDelegate.swift** contains code for  managing the app, it was common to add code there, but not anymore
- **SceneDelegate.swift** contains code for launching one window in the app, mostly important for iPad where multiple windows can be open
- **ContentView.swift** contains the initial user interface (UI) of the app
- **Assets.xcassets** is an _asset catalog_, a collection of assets to be used in an app
- **LaunchScreen.storyboard** is a visual editor for the launchscreen
- **Info.plist** contains a collection of special values that describe to the system how the app works, which version it is, which orientations are supported and more
- **Preview Content** is a group containing **Preview Assests.xcassets**, another asset catalog specifically for images to use when designing the UI

### ContentView.swift
- **import SwiftUI** tells Swift that the functionality from the SwiftUI framework is needed
- **struct ContentView: View** creates a new struct called _ContentView_ that conforms to the _View_ protocol, which comes from SwiftUI and is the basic protocol that must be adopted by anything that needs to be drawn on the screen
- **var body: some View** defines a computed property, _body_, which has the _some View_ type, that means it will return something that conforms to the View protocol. The _some_ keyword adds the restriction that it must always be the same view returned
- the **View protocol** requires that the conforming type has a computed property called _body_ that returns _some View_
- **Text("Hello World")** creates a text view, a simple piece of static text that gets drawn onto the screen and will wrap across multiple lines if needed
- **ContenView_Preview** conforms to the _PreviewProvider_ protocol and only exists so Xcode can show a preview of the UI alongside the code

## Creating forms
- **Form** is a dedicated view type for user input, _Forms_ are scrolling lists of static controls like text and images, but also include interactive controls like text fields, toggles, buttons and more
- each sub-view in a _Form_ gets his own row, unless something like a horizontal view is used to group multiple views in one row
- SwiftUI only allows for 10 subviews in a view, when more are needed they need to be placed in groups to avoid problems
- **Section** views can be used to split a _Form_ into multiple chunks

## Adding navigation bars
- by default SwiftUI ensures components are placed in the _safe area_, so they can't be covered by system UI or device corners
- to stop content from being scrolled under the clock, navigation bars can be added
- they can have titles and buttons, and in SwiftUI also have the ability to display new views when the user performs an action
- the **NavigationView** type is used to add them, to add a title the **.navigationBarTitle()** modifier is added with a string for the titles text
- **Modifiers** are like regular methods, but they always return a new instance of whatever they were used on, which means when using _modifiers_ Swift actually creates a new view that is then used
- for a slightly smaller font the **displayMode** parameter can be added to the modifier call
- a good example for larger and smaller titles used in a single app is the _Settings_ app

## Modifying program state
- **Views are a function of their state**, meaning how the UI looks is determined by a sequence of events, if the user is logged in, what buttons he has tapped etc...
- **state** is a collection of values that describe how the app is right now, while it's running
- Since _views_ in SwiftUI are _structs_ and _structs_ are immutable when created as a constant, the values inside the views can't be changed freely
- usually the _mutating_ keyword would be used for a struct method to change a property, but in SwiftUI views this is not allowed
- the **@State** _property wrapper_ is the solution to this problem, it is a special attribute put before a property and tells SwiftUI to store the value seperately, so that it can be modified
- why not use _classes_ instead? Because SwiftUI frequently destroys and recreate view structs as needed, so simple structs are important for performance
- since _@State_ is designed for simple properties that are only stored in one view, it is recommended to use _private_ access control for them

## Binding state to user interface controls
- for some views, like a text field, a **two-way binding** is needed, the value from the property needs to be written and read by the view
- any changes to the property will show up in the text field and any changes in the text field will update the property
- to mark a _two-way binding_ the **$** symbol is used before the property when used inside a view
- if the property only needs to be read, the _two-way binding_ is not needed

## Creating views in a loop
- sometimes views are created from data from an array, e.g. a list of names
- **ForEach** is the dedicated view type for this purpose, it can loop over arrays to create loops and isn't affected by the 10-view limit
- _ForEach_ will run a closure once for every item in the array, passing the current item to the closure
- it's particularly useful for the **Picker** view, which can show various options to select from
- inside the _Picker_ view a _forEach_ view is placed, which loops over an array and creates _text_ views for the picker to use

## Wrap up - Challenges
- Added a header to the third section, saying "Amount per person"
- Added another section showing the total amount for the check (original + tip value)
- Changed the "Number of people" picker to a text field

