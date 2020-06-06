# Animations
A technique project to learn more about animation in SwiftUI.

![App screenshot](Animations.png)


## Creating implicit animations
- are the simplest type of animation, they just tell the view how to respond if something tries to animate it
- this can be achieved by giving the view the `.animation()` modifier
- when any of the views modifier change - like padding, frame, scale, blur, etc - SwiftUI will automatically animate the change
- this allows for the animation to become a function of the apps state, just like views themselves

## Customizing animations
- to control the type of animation used, different values are passed to the `.animation()` modifier
- some values offer further customization, like `.interpolatingSpring(stiffness:, damping:`
- for most values it's also possible to pass a duration to them `.animation(.easeInOut(duration: 2))`
- in general it's possible to add further modifiers to the values passed

    ``` swift
    .animation(
        Animation.easeInOut(duration: 2)
            .delay(1)
    )
    ```
- it's important to note that this requires an explicit `Animation.easeInOut()`
- some modifiers that can be used for the animation values are `delay()`, `repeatCount(, autoreverse:)`, `repeatForever(autoreverse:)` and many more

## Animating bindings
- the `animation()` modifier can be applied to any SwiftUI binding, even things booleans, using the `.animation()` modifier
- e.g. `Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)`
- SwiftUI examines the state before the binding changes and the target state after the binding changed, then applies animation to get from A to B
- binding animations use the same `.animation()` modifier that normal views use, so they can have additional modifiers too

    ``` swift
    Stepper("Scale amount", value: $animationAmount.animation(
        Animation.easeInOut(duration: 1)
            .repeatCount(3, autoreverse: true)
    ), in: 1...10)
    ```

## Creating explicit animations
- using a `withAnimation()` closure will animate every state change that happens inside of it
- it's possible to use the same animation parameters that can be used elswhere too

    ``` swift
    withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
        self.animationAmount += 360
    }
    ```

## Summary
- implicit animations: view modifiers change on a view with the  `.animation()` modifier
- animated bindings: a binding with the `.animation()` modifier changes its value
- explicit animations: explicitely asking SwiftUI to animate something, useing `withAnimation()` closure

## Controlling the animation stack
- just like with normal modifiers, it's possible to apply multiple `.animation()` modifiers to a view
- every `.animation()` modifier controls all the state changes before it
- this makes it possible to have different animations for state changes instead of one uniform way to all properties
- it's also possible to pass `nil` to a `.animation()` modifier so that the changes before it happen immediately

## Animating gestures
- gestures can be attached to any view, via the `.gesture()` modifier, gestures will be covered in depth later
- using a `DragGesture()` and its two modifiers `.onChanged` and `.onEnded()` it's possible to use the input for an animation
- both modifiers are used to run a closure whenever the user moves their finger or lifts it off the screen respectively
- they are given a single parameter, which can be used to read the __translation__ - how far it's moved - of the drag
- using that value to change a state variable makes it possible to animate a gesture

## Showing and hiding views with transitions
- to customize the way views are shown and hidden, transistions can be used
- views are often hidden with a conditional `if`, wrapping the state change of its condition with `withAnimation` will animate the appearance of the view
- to customize this animation, the `.transition()` modifier is used
- it's possible to pass an `asymmetric(insertion:, removal)` to have different animations for appearing and disappearing

## Wrap up - Challenges
- 
