# Hot Prospects
An app to track who the users meets as conferences

![App screenshot](HotProspects1.png) ![App screenshot](HotProspects2.png) ![App screenshot](HotProspects3.png)

## Reading custom values from the environment 
- when passing data through a chain of views not every view always needs to use the data
- this can be solved by using **@EnvironmentObject**
- first a class conforming to **ObservableObject** with **@Published** properties is needed
- in the parent view (e.g. __ContentView__) a instance is created and passed into the environment
- the passing is done via the `.environmentObject(variableToPass)` modifier
- every subview that declares a property of the same type will automatically have access to it `@EnvironmentObject var someVariable: itsType`
- it's important to note that the app will crash if it can't find the type of the property in the environment
- behind the scenes SwiftUI makes the connection between the passed object and `@EnvironmentObject` properties via a __dictionary__ using the type of the passed object as the key

## Creating tabs with TabView and tabItem()  
- 

## Later parts
- understanding Swift's Result type
- manually publishing ObservableObject changes
- controlling image interpolation
- creating context menus
- scheduling local notifications
- adding Swift package dependencies in Xcode
- dynamically filtering a SwiftUI List

## Wrap up - Challenges
- 
