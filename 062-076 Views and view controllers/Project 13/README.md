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
## Wrapping a UIViewController in a SwiftUI View

## Using coordinators to manage SwiftUI view controllers
## Saving images to the photo library

## Building a basic UI
## Importing images into SwiftUI using UIImagePickerController
## Filtering images using Core Image

## Customizing via ActionSheet
## Saving images using UIImageWriteToSavedPhotosAlbum

## Wrap up - Challenges
- 
