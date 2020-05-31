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
- the **DateComponents** type allows for reading/writing specific parts of a date
- using the `date(from:)` method it's possible to create a __Date__ from __DateComponents__
- this method returns an optional date and should be used with nil coalescing to have a default value
- with the help of `Calendar.current.dateComponents(...)` it's possible to get components from a date value
- the first parameter of this method is an array of the components wanted, the second the date to get those components from
- the returned values are optionals again, so nil coalescing is advised
- to format a date to a string,  an instance of **DateFormatter** can be used
- after creating the instance, the `timeStyle` is set
- finally, using the `string(from:)` on the formatter instance, a string is created from the given date 

## Training a model with Create ML
- 

## Wrap up - Challenges
- 
