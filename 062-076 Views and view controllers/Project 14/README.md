# Bucket List 
An app that lets the user track places to visit

![App screenshot](BucketList1.png) ![App screenshot](BucketList2.png) ![App screenshot](BucketList3.png)


## Adding conformance to Comparable for custom types
- the reason that many of Swift's native types can be `sorted()` is because they conform to the `Comparable` protocol
- the only requirement for that protocol is the implementation of the `static func < (lhs: Type, rhs: Type) -> Bool` function
- this function overloads the `<` operator and  compares the two operands lhs (left-hand side) and rhs (right-hand side) that surround itr
- conforming to `Comparable` also enables access to the `>` operator, Swift creates it automatically be flipping the Boolean result of `<`
- inside the overloaded operator function can be as much code as needed, as long as the return value is a Boolean, true if the lhs value is 'smaller' than the rhs value

## Writing data to the documents directory
- for data that is too big for __UserDefaults__ and should be automatically synchronized, the **Documents** directory should be used
- since all apps are sandboxed the URL for the directory is not guessable
- to get the URL, the `FileManager` class is used: `let paths = FileManage.default.urls(for: .documentDirectory, in: .userDomainMask)`
- this returns a list of urls, but should only contain one in the case of the document directory, so the url in `paths[0]` can be used
- it's common to have a `getDocumentsDirectory() -> URL` function for this specific functionality, or an extension on `FileManager` itself
- to save data to the directory the `write(to:)` method is called on the data, this should be wrapped in a `do{ ... } catch{ ... }` since it `throws`
- the url given to `write(to:)` should also contain the file name and extension, this is achieved by `documentsUrl.appendingPathComponent("File.txt")`
- for the String types this takes 2 more parameters: `atomically`, if everything should be written at once; and `encoding` which simply is the character encoding (utf8 in most cases)
- to load the data back, the intializer of the type of the data is used `Type(contentsOf:)`, this should also be wrapped in a `do{ ... } catch{ ... }`

## Switching view states with enums
- when using conditional views and there are several different states, enums are a good way to keep the code small and easy to maintain
- just like with conditional views it's possible to check property for the state of a subview and display the correct subview

    ```swift
    enum LoadingState {
        case loading, success, failed
    }
    ```

    ```swift
    Group {
        if loadingState == .loading {
            LoadingView()
        } else if loadingState == .success {
            SuccessView()
        } else if loadingState == .failure {
            FailedView()
        }
    }
    ```

## Integrating MapKit with SwiftUI
- wrapping a **MKMapView** works similarly to a __UIImagePickerController__, but uses the `UIViewRepresentable` protocol instead
- it still requires a __make__ and an __update__ function, `makeUIView(context:)` and `updateUIView(view:, context:)` respectively
- the `context` for both of them is `UIViewRepresentableContext<MapView>`
- `UIViewRepresentable` uses a typealias for context that makes use of a generic type, passed via the arguments `typealias Context = UIViewRepresentableContext<Self>`
- this allows for just writing `Context` instead of `UIViewRepresentableContext<MapView>` every time

## Communicating with a MapKit coordinator
- like before a `Coordinator`class is needed, this time conforming to `NSObject` and `MKMapViewDelegate`
- again initializing its parent property of type `MapView`, the wrapping struct
- the wrapping struct needs to have a `makeCoordinator()` function
- and assign the coordinator as a delegate in the `makeUIView()` method: `mapView.delegate = context.coordinator`
- **MapKit** will automatically examine the coordinator class and notify it based on the functions the class implements, e.g. `mapViewDidChangeVisibleRegion(mapView:)`
- **Annotations** are create by using `MKPointAnnotation()`, after that the annotations properties should be set `title`, `subtitle` and `coordinate`
- to assign an Annotation to a MapView `addAnnotation()` is called on the MapView and the annotation is passed
- to customize the way annotations look the `mapView(_:viewFor:)` method can be added to the coordinator class
- insite it a view of type `MKPintAnnotationView` needs to be created, configured and returned

## Using Touch/Face ID with SwiftUI
- when using biometric authentication a key has to be added to the info.plist file 'Privacy - Face ID Usage Description'
- this is given a reason, as a string, on why the app needs Face ID, the reason for Touch ID is given in code
- an import to `LocalAuthentication` is needed to make use of Face/Touch ID
- after creating an instance of `LAContext` the `canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)` can check if the device has Face/Touch ID
- the first argument is the authentication policy that is checked for, the second is a pointer to a `NSError` variable, which will be filled if there is an error
- if the device has Face/Touch ID, `evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Touch ID reason")` starts the authentication
- it expects a completion closure which is given a `Bool`, which indicates the success, and a `Error?`, which has a value when there was an error
- inside the closure the success/failure is handled, e.g. with @State variables

## Advanced MKMapView with SwiftUI
- to communicate with a MKMapView bindings in it's wrapper are used
- every time the map is moved `mapViewDidChangeVisibleRegion()` is called, in there the binding can be updated
- to display annotations on the map a simple array of `[MKPointAnnotation]` in the wrapper is sufficient
- in `updateUIView(view:,context:)` the annotations can be updated by calling `removeAnnotations()` and `addAnnotations()` on the view
- it's best to check if the amount of annotations has checked beforehand `if annotations.count != view.annotations.count { ... }`

## Customizing MKMapView annotations
- to customize annotations the `mapView(_:viewFor:)` method is used inside the coordinator class
- for the best performance annotation views should be reused, which is possible by calling `dequeueReusableAnnotationView(withIdentifier:)` inside the above function
- the identifier passed is a string that can be freely assigned to annotations when creating them
- if there is no reusable annotation available, a new one needs to be created (and should get an identifier for reuse)
- to allow the annotation to show pop-up information the `canShowCallout` property of it is set to true
- adding a button to it can be accomplished by setting the `rightCalloutAccessoryView` with e.g. `UIButton(type: .detailDisclosure)`
- callouts will only show for annotations that have their title property set
- to set the detail informations bindings for the selected annotation and a boolean for whether or not the detail is showing can be used
- inside the parent view the state variables for those are passed to the MapView and an alert is shown when boolean binding is true, with the info from the selected annotation
- updating those bindings should be done in the `mapView(_:annotationView:calloutAccessoryControlTapped)` function inside the coordinator class

## Extending existing types to support Observable Object
- since MKPointAnnotations `title` and `subtitle` properties are both optional, they can not be observed
- the solution to make them observable is adding an Extension to `MKPointAnnotation` and make it conform to `ObservableObject`
- all that is needed is a computed property for each with a getter and setter, where the getter uses nil-coalescing

## Sorting downloaded data
- to sort downloaded data, the model simply has to conform to the `Comparable` protocol
- that means implementing a `static func < (lhs: Type, rhs: Type) -> Bool { ... }` function
- this function compared whatever is deemed relevant to sorting and returns a boolean based on whether the `lhs` value is smaller than the `rhs` value
- after adding conformance the `sorted()` method can be called on an array of the models type

## Adding conformance to Codable for a third party class
- adding conformance for Codable to an existing class is not always possible via an Extension
- one way to add conformance would be by subclassing and implementing the required `init(from:)` and `encode(to:)` functions
- since a subclass can mostly be used whereever it's parent was used too, the only places where the type needs to be explicitely changed is for loading & saving

## Wrap up - Challenges
- increase the tap-able area of the '+' button
- refactor main UI, extract the views inside the 'if' into their own view 
- show alerts when the authentication fails
