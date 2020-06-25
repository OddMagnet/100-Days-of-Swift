# Bookworm
An app that tracks which books a user has read and his thoughts on them

![App screenshot](PROJECT_NAME.png)


## Creating a custom component with @Binding
- @State is used when working with local value types
- @ObservedObject when working with sharable reference types
- but what is used when creating custom views that change state in some other view, like `Picker`, `Stepper` etc?
- the answer to that is `@Binding`, it allows to create a mutable value in a view, that points to some other value elsewhere
- this makes it possible to have an `@State` property in the main-view and pass it to a child-view which can manipulate it

## Using size classes with AnyView type erasure
- aside from `\.presentationMode` the environment contains many more properties, like `\.horizontalSizeClass` and `\.verticalSizeClass`
- both of those properties can be either `.compact` or `.regular` and tell us about the currently available screen space
- this is useful for example when using multi-tasking on the iPad
- sometimes a different View should be showed depending on the size class, but returning two different views in a body is not possible
- to accomplish this, **type erasure** can be used, which is done by simple wrapping the view in `return AnyView( /* View here */ )`
- `AnyView` does not expose what it contains externally, which makes it possible to return different views
- this comes with the downside of SwiftUI not being able to only re.render small parts of the UI

## How to combine Core Data and SwiftUI
- **Core Data** is used to define objects and properties of those objects and allow for reading/writing them from/to permanent storage
- it is similiar to __Codable__ and __UserDefaults__ but also allows for sorting and filtering data, and can handle much larger data
- additionally it offers data validation, lazy loading of data, undo/redo and more
- when using **Core Data** Xcode will generate a `ProjectName.xcdatamodeld` file that describes the data model (= classes and their properties)
- Xcode also sets up `AppDelegate.swift` and `SceneDelegate.swift` with the necessary code to use Core Data
- to actually use Core Data a **persistent container** which loads and saves data to storage is needed and it needs to be injected into the environment
- both of these things are setup automatically by Xcode when the checkbox for using CoreData was checked at project creation
- inside the `xcdatamodeld` file **Entities** (classes) and **Attributes** (properties) can be created
- these can then be accessed via the `@FetchRequest` wrapper: `@FetchRequest(entity: EntityName.entity(), sortDescriptors: []) var entity: FetchedResults<EntityName>`
- this creates a fetch request for 'EntityName' (without any sorting) and places it into the `entity` property of type `FetchedResults<EntityName>`
- the attributes of the entity can then be accessed via that property
- what Core Data automaticlly creates based on the given Entity is a class that inherits from its own `NSManagedObject` class
- these are also called __managed objects__, all managed objects are managed by the **managed object contect**, which is what actually does the fetching and saving of changes
- since Xcode already created this automatically, only a property from the environment needs to be created to use it: `@Environment(\.managedObjectContext) var moc`
- from that new objects can be created `let object = Entity(context: self.moc)`, changed/filled with data `object.id = UUID()` and saved `try? self.moc.save()`

## Miscellaneous
### Creating books with Core Data
- for view not presented with an ancestor view, e.g. via `sheet()` an environment object must be passed by calling `.(environment(...)` on the view
### Adding a custom star rating component
- to provide bindings for the previews in SwiftUI, __constant bindings__ can be used. e.g. inside the preview view `SomeView(someBinding: .constant(/* value here */))`
### Building a list with @FetchRequest
- variables wrapped by `@FetchRequest` can be used in ForEach just like arrays
### Showing book details
- when creating a view that uses a Core Data entity, the preview needs a __temporary__ managed object context to create an instance of the needed entity
- this is done with an **NSManagedObjectContext**: `static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)`
- to use a view that requires a binding without enabling it to actually change anything, `.constant(/* binding property value here */)` can be used
### Sorting fetch requests with NSSortDescriptor
- sorting the data that of a __@FetchRequest__ wrapped property is done by supplying `NSSortDescriptor(keyPath:, ascending)` to the `sortDescriptors` argument of the wrapper
- it's possible to supply multiple sort descriptors, e.g. sorting by Author and Book Titles. A keypath would look something like this `keyPath \Entity.attribute`
### Deleting from a Core Data fetch request
- just like with lists of arrays, lists of data from fetch request can also be used to delete data from Core Data
- inside the from `.onDelete(perform:)` called function `moc.delete(objectToDelete)` is called and the context is saved: `try? moc.save()`
## Using an alert to pop a NavigationLink programmatically
- when presenting an alert to confirm the deletion (or change) of some data, the confirming button in the alert should be of type `.destructive()`

## Wrap up - Challenges
- 
