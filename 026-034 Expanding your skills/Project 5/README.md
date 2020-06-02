# Word Scramble
A simple wordgame, showing a random word and asking the player to make words from its letters.

![App screenshot](WordScramble.png)


## Introducing List
- the **List** view provides a scrolling table of data, similiar to the __Form__ view
- while Form views are mostly used for user input, List views are for presenting data
- List views work with both static views or dynamically created ones and even with both mixed
- a good example of mixed views in a list is the settings app, e.g. the Wi-Fi section
- lists can be styled similiar to forms using the `.listStyle(GroupedListStyle())` modifier
- if a list contains only dynamic views it can be used with a range parameter, e.g. `List(0..<array.count)`
- the `id` parameter is used so that SwiftUI can uniquely identify each row
- for arrays of strings and numbers, their values themselves make them unique, so `id: \.self` can be used
- to mix static views and uniquely identified views in a list, `ForEach` has to be used

## Loading resources from the app bundle
- for **Image** views SwiftUI automatically looks in the app's asset catalog and adjusts the images size for the device
- other data types are usually stored in the apps **Bundle** and accesses via the **URL** data type
- to get the url for a file the `url(forResource:, withExtension:)` method is called on the bundle the file is in
- e.g. `Bundle.main.url(forResource: "some-file", withExtension: "txt")`
- then the content of the file needs to be loaded into a variable of fitting type
- e.g. text into a string variable via the `String(contentsOf:)` initializer

## Working with strings
- 

## Wrap up - Challenges
- 
