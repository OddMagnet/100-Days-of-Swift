# Accessibility
A technique project to learn about adding accessibility features

![App screenshot](_fixed.png)


## Identifying views with labels
- to make use of the VoiceOver feature, views need to be provided with the `.accessibility()` modifier
- this modifier takes a variety of (single) arguments, for example `label` which is a string that will be read when the view is selected
- `hint` will be read with a short delay after label and is used to provide additional details
- some other useful argument are `addTraits` and `removeTraits` which are used to tell VoiceOver that something does or does not have specific traits (e.g. an image also being a button)

## Hiding and grouping accessibility data
- often times there are elements of the UI that are irrelevant to VoiceOver users
- for examples: decorative images, grouped views or off-screen views
- to mark an image as decorative `Image(decorative:)` should be used, this stops the filename from being read
- it's still possible to add traits to decorative images, these will be read when it's highlighted
- using the `hidden` argument makes the view complete insivible to VoiceOver, this is especially useful for off-screen views
- when multiple views are combined in a group, e.g. a V-/HStack with multiple Text views, it's useful to use the `accessibilityElement(children:)` modifier
- this can be used to let VoiceOver know that the views in the group should be combined with `.combine` or ignored with `.ignore`
- when using `.ignore` it's recommended to provide a custom label

## Reading the value of controls
- another important use of VoiceOver is reading the value of control elements
- by default VoiceOver would read a percentage for e.g. `Slider`
- to circumvent this, the `value` argument can be used

    ```swift
    Slider(value: $estimate, in: 0...50)
        .accessibility(value: Text("\(Int(estimate))"))
    ```

## Adding accessibility to
- [Project 2 - GuessTheFlag](https://github.com/OddMagnet/100-Days-of-Swift/blob/master/016-024%20Starting%20SwiftUI/Project%202)
- [Project 5 - Word Scramble](https://github.com/OddMagnet/100-Days-of-Swift/tree/master/026-034%20Expanding%20your%20skills/Project%205)
- [Project 11 - Bookworm](https://github.com/OddMagnet/100-Days-of-Swift/tree/master/049-059%20Focus%20on%20data/Project%2011)

## Wrap up - Challenges
- 
