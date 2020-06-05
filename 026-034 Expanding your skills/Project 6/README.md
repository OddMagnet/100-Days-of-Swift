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
- 

## Creating explicit animations
- 

## Wrap up - Challenges
- 
