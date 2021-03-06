# Hot Prospects
An app to track who the users meets at conferences

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
- when showing unrelated data, a **TabView** is often the way to go
- this is achieved by simply placing the desired views into a TabView
- the `.tabItem()` modifier is used on the views inside to give them an image and text to display in the tabbar on the bottom of the screen
- in SwiftUI 1.0 this is done via a closure with an Image and Text view, in 2.0 via the Label view
- it's also possible to switch between tabs programmatically:
    - pass a @State property to the `selection:` argument of the TabView
    - use the `.tag()` modifier to tag the views inside the TabView
    - set the @State property to whatever tag should be switched too

## Uunderstanding Swift's Result type
- often functions either return data or an error, usually via throwing, but this is not possible when the function doesn't return immediately
- to resolve this, Swifts **Result** type is used, it will either hold a value or an error, but never both or neither
- behind the scenes it's an Enum with associated values and two cases `.success(Data)` and `.failure(Error)`
- a custom enum that conforms to the `Error` protocol is used for the `failure(Error)` case
- to make use of the Result type, the function simply has to use it as its return value: `func someFunction() -> Result<String, SomeErrorEnum> { ... }`
- inside the function either `return .success(theData)` or `.failure(.someErrorEnumCase)` is used
- since this type is usually used for asynchronous functions, the function should have an argument for a completion closure
- `func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) { ... }`
- the `@escaping` is needed for an asynchronous function to retain whatever called the function in memory, so the closure can run later on
- inside an asynchronous function, instead of returning a Result case, the completion closure is called and supplied with either `.success(theData)` or `.failure(.someErrorCase)`

## Manually publishing ObservableObject changes
- it's possible to manually publish changes in an ObserableObject
- for this, the `@Published` wrapper is removed from the property that should be manually published
- it is then changed into a computed property and inside its `willSet` `objectWillChange.send()` is called
- this allows for additional code before the change is published, e.g. for logging purposes

## Controlling image interpolation
- when Image views are stretched bigger than the source image, SwiftUI applies image interpolation by default
- usually this works well enough to not worry about, but for especially small images or pixel art the interpolation might be unwanted
- to disable the interpolation simply applying the `.interpolation(.none)` modifier is enough

## Creating context menus
- to add a context menu - a menu that appears on long pressing - to something, the `.contextMenu()` modifier is used
- inside the modifier buttons can be placed and like tabItem they can have a Text and an Image view (or just Label in SwiftUI 2.0)
- a few rule of thumbs for context menus:
    - if they're used, they should be used often to avoid user frustration
    - the list of options should be kept short, ideally 3 or under
    - options already displayed in the UI should not be repeated

## Scheduling local notifications
- to schedule local notifictions `UserNotifications` must be imported
- before notifications can be scheduled, first the user needs to give permission
- this is done via `UNUserNotificationCenter.current().requestAuthorization(options:, completion:)`
- which takes an array of possible options (e.g. `.alert`, `.badge`, `.sound`) and a completion closure, which is used to check for success
- once permission was granted, a notification can be scheduled, this requires 3 steps:
    - creating the content `let content = UNMutableNotificationContent()` and setting it's `title`, `subtitle` and `sound` properties
    - creating a trigger, e.g. via `let trigger = UNTimeIntervalNotificationTrigger(timeInterval:, repeats)` which takes a time interval and a boolean whether or not it should repeat
    - combining content and trigger in a request `let request = UNNotificationRequest(identifier:, content:, trigger:)`
- after creating the request, it can be added to the Notification Center `UNUserNotificationCenter.current().add(request)`

## Adding Swift package dependencies in Xcode
- adding a dependency is as simple as clicking __File__ -> __Swift Packages__ -> __Add Package Dependency__
- then configuring some options, like up to which version should be used
- and finally just using it where it's needed: `import TheImportedPackage` 

## Dynamically filtering a SwiftUI List
- since List views are also able to take computed properties, adding a dynamically filtered list is easy
- first a computed property is needed, that returns a filtered array, e.g. based on an enum state
- the `.filter()` method takes a closure that needs to return a boolean, which determines whether or not the current element is included
- the computed property can be used just like any other array in a List view
- if the initial array is a `@State` variable or an `@ObservedObject` changes to it will also update the filtered list

## Generating and scaling up a QR code
- to generate a QR code `import CoreImage.CIFilterBuiltins` is needed
- as usual a context is created `let context = CIContext()` and a filter `let filter = CIFilter.qrCodeGenerator`
- next the data for the generator needs to be set, this requires the `Data`type: `filter.setValue(data, forKey: "inputMessage")`
- finally the output image can be from the filter and converted to e.g. an UIImage

```swift
if let outputImage = filter.outputImage {
    if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
        let uiImage = UIImage(cgImage: cgImage)
        // do something with the UI image
    }
}
```
- since the image will only contain as many pixels as needed to display the code, it needs to be upscaled
- for this the `.interpolation(.none)` modifier should be applied to the image, so it isn't blurred

## Scanning QR codes with SwiftUI
- for the scanning of QR codes the **CodeScanner** package of __Paul Hudson / @TwoStraws__ is used

## Wrap up - Challenges
- add an icon to the "Everyone" screen, indicating whether a prospect has been contacted or not
- save user data
- add sorting of users
