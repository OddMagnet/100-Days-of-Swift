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
- The **View protocol** requires that the conforming type has a computed property called _body_ that returns _some View_
- **Text("Hello World")** creates a text view, a simple piece of static text that gets drawn onto the screen and will wrap across multiple lines if needed
- **ContenView_Preview** conforms to the _PreviewProvider_ protocol and only exists so Xcode can show a preview of the UI alongside the code
