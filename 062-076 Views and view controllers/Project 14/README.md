# Bucket List 
An app that lets the user track places to visit

![App screenshot](PROJECT_NAME.png)


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

## Later parts
 - advanced MKMapView with SwiftUI
 - customizing MKMapView annotations
 - extending __existing types__ to support **Observable Object**
 - downloading data from Wikipedia & sorting the results
 - adding conformance to Codable for a third party class
 - locking UI behind Touch/Face ID

## Wrap up - Challenges
- 
