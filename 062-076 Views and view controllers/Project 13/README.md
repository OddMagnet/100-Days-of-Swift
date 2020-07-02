# Instafilter
 An app that lets users import photos from their library and modify them using multiple image effects.

![App screenshot](Instafilter.png)


## How property wrappers become structs
- behind the scenes property wrappers are just structs wrapping around a value
- usually structs can't be changed, but property wrappers use the **nonmutating** keyword for the variable's setter
- this tells Swift to not change the struct itself

## Creating custom bindings in SwiftUI
- a custom binding is create using the following initializer: `init(get: @escaping () -> Value, set: @escaping (Value) -> Void)`
- this means it expects a getter that returns a generic value and a setter that takes a generic value and returns nothing
- both of them are closures that are saved for later use (`@escaping`)
- since it's not possible to use 'didSet' on property wrappers, such custom bindings can be used as a __passthrough__ 

    ``` swift
    let someBinding = Binding<theTypeOfTheBinding>(
        get: {
            self.theStatePropertyBeingObserved
        },
        set: {
            self.theStatePropertyBeingObserved = $0
            // do something here, e.g. saving to UserDefaults
         }
    )
    ```

## Showing multiple options with ActionSheet
- **ActionSheet** can be used just like alert
- the `.actionSheet(isPresented:)` takes a binding that decides if it's currently presented and a closure that contains the actual ActionSheet
- `ActionSheet(title:, message:, buttons:)` takes two strings for title and message, and an array of buttons which themselves need a title and a closure
- ActionSheet offers 3 types of buttons for the buttons array: `.default`, `.cancel` and `.destructive` 
- all can be given a title and either a normal closure as an argument or a trailing closure

## Integrating Core Image with SwiftUI
- `Image` is just a view used to display images in SwiftUI, but can't actually manipulate them
- for this puprose `CIImage`, the image type of **Core Image** is used
- the easiest way to load an Image for manipulation is by loading it into an `UIImage`then convert to `CIImage`
- to make use of Core Image an import is needed: `import CoreImage`, for easier use `CoreImage.CIFilterBuiltins` should be imported too
- a context variable is needed to create the image from an applied filter `let context = CIContext()`
- and a variable for the filter that should be used `let filter = CIFilter.sepiaTone()` for example
- then the filter is configured by setting its `inputImage` property and the necessary properties for the filter, e.g. `intensity`
- to convert back and display the Image in SwiftUI:
    - first the output is read, this returns an optional CIImage `guard let outputImage = filter.outputImage else { ...  }`
    - next a CGImage is create from the context, this also returns an optional `if let cgImage = context.createCGImage(outputImage, from outputImage.extent)`
    - then it's converted to an UIImage `let uiImage = UIImage(cgImage: cgImage)`
    - and finally to the Image view of SwiftUI `let image = Image(uiImage: uiImage)`
- this requires a lot of converting, but the actual use of filters is quite simply, aside from a few specific filters it's easy to interchange them

## Wrapping a UIViewController in a SwiftUI View
- to display an `UIView` in Swift, a struct is needed that conforms to the `UIViewControllerRepresentable` protocol
- the easiest way to add the needed conformance is to add a typealias and use Xcode to 'fix' the missing functions
- the typealias tells Xcode exactly what functions would be needed for the controller type that the struct is wrapping
- `typealias UIViewControllerType = UIImagePickerController` for example would let Xcode add the conformance needed for an UIImagePickerController
- the `makeUIViewController()` is then used to create the needed UIView and return it, e.g. `return UIImagePickerController()`
- `updateUIViewController` can be used to update the view controller when some state in SwiftUI changes
- after properly wrapping the UIView the wrapping View can be used like any other

## Using coordinators to manage SwiftUI view controllers
- to respond to events that occur in a wrapped SwiftUI view, **coordinators** are used
- for this a `Coordinator` class is added to the wrapping struct, which conforms to `NSObject`, `UIImagePickerControllerDelegate` and `UINavigationControllerDelegate`
- `NSObject` allows Objective-C to check which functionality the object supports at runtime
- `UIImagePickerControllerDelegate` adds functionality to detect when the user has selected an image
- `UINavigationControllerDelegate` enables detection of when the user moves between screens
- depending on the UIView being wrapped the protocols needed are different of course, in this example a UIImagePickerView is being wrapped
- additionally a `makeCoordinator() -> Coordinator` class is needed for SwiftUI to automatically get an instance of the coordinator
- in the `makeUIViewController()` function the coordinator can then be set as the delegate, e.g. `picker.delegate = context.coordinator`
- when handling data between a parent view and a wrapped UIVIew, a binding inside the wrapping struct enable the data being stored inside the parent view
- for the UIView to be able to set a value to that binding it needs a connection to the wrapping view
- inside the coordinator class a property is added: `var parent: WrappingStruct` and assigned on the init `init(_ parent: WrappingStruct) { self.parent = parent }`
- finally, the methods of the wrapped UIViews delegate protocol need to be implemented to enable some functionality
- for example: `func imagePickerController(picker:, didFinishPickingMediaWithInfo info:)`
- inside of that function the selected image can be saved to the parent `if let img = info[.originalImage] as? UIImage { parent.image = img }`
- to programmatically dismiss the wrapped UIView the __presentationMode__ environment variable can be added to the struct and called when needed `parent.presentationMode.wrappedValue.dismiss()`
- when presenting the wrapped UIView, e.g. in sheet, the `onDismiss` argument should be added to handle the data being returned

## Saving images to the photo library
- to actually save an image to the user's photo library, permission is needed, while this is handled by iOS, a string in the `info.plist` file is needed
- this string will be the message that iOS displays to the user when asking for permission, simply adding a row with a key of `Privacy - Photo Library Additions Usage Description` and a message is enough
- the simplest way to save an image would be to just call `UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)`, but it's good practice to not just ignore the other 3 parameters
- the 2nd and 3rd parameter tell Swift what method should be called once the saving is complete, which is useful to know if the saving actually succeeded
- why two parameters? the first of those two points to an object and the second of those two to the name of the method that should be called
- this is because the code for that UIKit function is very old, pre-Objective-C's equivalent of closures
- the object provided must be a class that inherits from `NSObject`
- the method is provided not by the actual method, but it's name, which Objective-C will look up at runtime
- inside the `UIImageWriteToSavedPhotosAlbum` call the method name is wrapped by a selector `#selector(methodName)` which tells Swift to make sure the name exists
- the method being called must be marked with the `@objc` attribute, which tells Swift to generate code that's readable by Objective-C
- the fourth parameter accepts any kind of data - since it's of type `UnsafeRawPointer`- and is passed back to the completion method

## Building a basic UI
## Importing images into SwiftUI using UIImagePickerController
## Filtering images using Core Image

## Customizing via ActionSheet
## Saving images using UIImageWriteToSavedPhotosAlbum

## Wrap up - Challenges
- 
