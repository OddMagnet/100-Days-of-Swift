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
- 

## Working with strings
- 

## Wrap up - Challenges
- 
