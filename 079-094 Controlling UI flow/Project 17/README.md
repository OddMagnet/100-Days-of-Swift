# Flashzilla
An app that helps the user learn by using flashcards

![App screenshot](Flashzilla1.png) ![App screenshot](Flashzilla2.png) ![App screenshot](Flashzilla3.png)


## How to use gestures in SwiftUI
- aside from the commonly known tap gesture, which has it's own modifier, there is a wide variety of other gestures
- `.onTapGesture(count:)` also supports a count parameter, e.g. for double & triple taps
- `.onLongPressGesture` is used for handling long presses and also supports a `minimumDuration` parameter as well as a `pressing` parameter
- `minimumDuration` takes the number of seconds, while `pressing` takes a closure that is executed before the minimumDuration is met
- for more advanced gestures the `.gesture()` modifier is used, which takes a gesture struct as it's argument
- this includes (but not limited to): `DragGesture`, `LongPressGesture`, `MagnificationGesture` and `RotationGesture`
- many of these have two special modifiers, `onChanged()` and `onEnded()` which both take a closure and provide a value (based on the gesture) to the closure
- example:

```swift
Text("Pinch me")
    .scaleEffect(finalAmount + currentAmount)
    .gesture(
        MagnificationGesture()
            .onChange { amount in
                self.currentAmount = amount -1
            }
            .onEnded { amount in
                self.finalAmount += self.currentAmount
                self.currentAmount = 0
            }
    )
```
- depending on the gesture used a different modifier before it has to be used, e.g. `.scaleEffect()` for `MagnificationGesture`, `.rotationEffect()` for `RotationGesture`, etc.
- when a view and its parent both have the same gesture modifier, one has to be given higher priority `.highPriorityGesture(/* the gesture */)`
- alternatively they could be used simultaniously by giving the parent the `.simultaneousGesture(/* the gesture */)` modifer
- finally, it's also possible to sequence gestures by calling `.sequenced()` on a gesture and passing another gesture

## Making vibrations with UINotificationFeedbackGenerator and Core Haptics
- one of the easiest ways to give haptic feedback is by simply using `UINotificationFeedbackGenerator`
- after creating an instance, simply calling `.notificationOccured()` on it is enough to get the haptic feedback
- for more advanced haptic feedback the **CoreHaptics** framework is needed `import CoreHaptics`
- to make use of it a `CHHapticEngine` is needed `@State private var hapticEngine: CHHapticEngine?`
- which should be created as soon as the view appears

```swift
guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return  }
do {
    self.hapticsEngine = try CHHapticEngine()
    try engine?.start()
} catch {
    /* handle errors */
}
```
- to make use of the engine, parameters for intensity and sharpness are needed, an event needs to be created and passed to the pattern which is then used to create a players with said pattern
    - both intensity and sharpness are created by using `CHHapticEventParameter(parameterID:, value)`
    - the event is created via `CHHapticEvent(eventType:, parameters:, relativeTime)` 
    - where `parameters` expects an array of `CHHapticEventParameter`, most commonly the intensity and sharpness values
    - and `relativeTime` is used to create events in a sequence
    - next a pattern is created `CHHapticPattern(events:, parameters)`, where `events` expects an array of events and `parameters` an array of parameters to apply to all events
    - to create the player `makePlayer(with: )` is called on the haptics engine instance with the pattern for the player
    - finally, to use the player `start(atTime:)` is called on it
- it's possible to add multiple different events with different parameters to the array that is passed to the pattern

## Disabling user interactivity with allowsHitTesting()
- 

## Triggering events repeatedly using a timer
- 

## Getting notified when the app moves to the background
- 

## Supporting specific accessibility needs with SwiftUI
- 

## Moving views with DragGesture and offset()
- 

## Wrap up - Challenges
- 