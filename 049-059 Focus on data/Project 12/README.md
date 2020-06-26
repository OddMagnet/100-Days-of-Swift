# Core Data
A technique project to explore how Core Data and SwiftUI work together

## Why does \.self work for ForEach
- when using `\.self` Swift calculates the hash of the object and uses that as an identifier
- a hash is a unique value that has a fixed length and is calculated based on the objects content
- in order for Swift to be able to calculate the hash of an object, that objects class has to conform to `Hashable`
- the class that Xcode generates for Core Data entities automatically conforms to the `Hashable` protocol
- even identical objects in Core Data will have a unique hash since Core Data creates a few other properties (e.g. object ID) beyond the defined properties

## Creating NSManagedObject subclasses
- 

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
