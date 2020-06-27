# Core Data
A technique project to explore how Core Data and SwiftUI work together

## Why does \.self work for ForEach
- when using `\.self` Swift calculates the hash of the object and uses that as an identifier
- a hash is a unique value that has a fixed length and is calculated based on the objects content
- in order for Swift to be able to calculate the hash of an object, that objects class has to conform to `Hashable`
- the class that Xcode generates for Core Data entities automatically conforms to the `Hashable` protocol
- even identical objects in Core Data will have a unique hash since Core Data creates a few other properties (e.g. object ID) beyond the defined properties

## Creating NSManagedObject subclasses
- there are 2 ways to remove the the constant handling of optionals when using Core Data
- both require to switch from __Class Definition__ **Codegen** to __Manual/None__ in the data model inspector in Xcode
- next a NSManagedObject subclass needs to be created for the respective entity: Editor menu -> 'Create NSManagedObject Subclass...'
- in the 'EntityName+CoreDataProperties.swift' file the code can be changed in two ways:
- either just removing the '?' from the properties
- or creating computed properties that handle the nil-coalescing
- the `@NSManaged` in front of the properties is not a property wrapper, but more of a 'link' to how Core Data works internally
- rather than values actually existing as properties in a class, they are just read and written to a dictionary that Core Data store its information in
- since Core Data loads its data lazily (only when needed), just removing the '?' can lead to problems when data without values is saved

## Conditional saving of NSManagedObjectContext
- the recommended way of using the `save()` method of `NSManagedObjectContext` is by checking if there any changes first
- this can be accomplished by using either the `hasChanged` property of an object
- or calling `self.moc.hasChanges` to check if the entire context has any changes
- this way unnecessary performance impact can be avoided

## Ensuring Core Data objects are unique by using constraints
- to stop users from saving multiple identical objects in Core Data, constraints can be used
- in the data model inspector constraints can be added by clicking the '+' below **Constraints** and adding the constrained properties as a comma seperated list
- when trying to save multiple objects with the same constrained property the `save()` method of the context will now throw an error that needs to be handled
- to make Core Data still write the changes, the context can be given a **mergePolicy** inside the SceneDelegate.swift file
- for this an `import CoreData` is needed and then the contect can be added just below its creation like this `context.mergePolicy = /* the desired policy here */`

## Filtering @FetchRequest using NSPredicate
- to filter a FetcRequest an **NSPredicate** is supploed: `NSPredicate(format: "universe == 'Star Wars'")`
- the more common syntax is to use `%@` instead of just quote marks, where data will be inserted `NSPredicate(format: "universe == %@", "Star Wars")`
- it's also possible to use `<` and `>` for filtering `NSPredicate(format: "name < %@", "F")`
- `%@` also converts native Swift types to their Core Data equivalents, like `IN`, `BEGINSWITH`, `CONTAINS` and even negating with `NOT`
- both `BEGINSWITH` and `CONTAINS` are case sensitive, but can ignore case by addding a `[c]` at the end: `NSPredicate(format: "name BEGINSWITH[c] %@", "e")`
- for even more precise predicates it's possible to use `AND` or create a `NSCompoundPredicate`

## Dynamically filtering @FetchRequest with SwiftUI
-

## One-to-many relationships with Core Data, SwiftUI and @FetchRequest
- 

## Wrap up - Challenges
- 
