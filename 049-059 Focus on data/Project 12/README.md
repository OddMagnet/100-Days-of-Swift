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
- 

## Ensuring Core Data objects are unique by using constraints
- 

## Filtering @FetchRequest using NSPredicate
-

## Dynamically filtering @FetchRequest with SwiftUI
-

## One-to-many relationships with Core Data, SwiftUI and @FetchRequest
- 

## Wrap up - Challenges
- 
