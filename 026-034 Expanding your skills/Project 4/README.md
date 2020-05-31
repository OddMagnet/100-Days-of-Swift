# BetterRest
This project is an app designed to help coffee drinkers get a good night's sleep by using Machine Learning

![App screenshot](BetterRest.png)


## Entering numbers with Stepper
- one of the ways SwiftUI lets users enter numbers is by using a **Stepper** view
- the other option would be a __Slider__, which is less precise
- Steppers can adapt to any kind of number they are bound to
- to limit the values of a stepper a range is used `Stepper(value: $var, in: 1...10) {...}`
- another useful parameter for steppers is the step value `Stepper(..., step: 0.25) {...}`

## Selecting dates and times with DatePicker
- SwiftUI offers a dedicated picker type, **DatePicker** that can be bound to a **Date** property
- by default the view provides a spinning wheel with a label to the left
- if used in a __Form__ view it'll change to a single row that folds out when tapped
- alternatively, to not show the label outside of a __Form__ view, the `.labelsHidden()` modifier can be used
- this way it shows the spinning wheel without a label, but the original label will still be read by screenreaders
- using the `displayedComponents` parameter the picker can be further configured to show different components
- as with stepper, there is a `in` parameter that accepts a date range (also accepts one-sided ranges)

## Working with dates
- 

## Training a model with Create ML
- 

## Wrap up - Challenges
- 
