# Touch Ripple For Flutter
![developers_github_banner – 2](https://github.com/Louibooks/Flutter_Touch_Ripple/assets/122026021/f194abbc-4401-485e-ad06-ecbf1d60b806)

### Customizable touch ripple for flutter widget

This Flutter package allows developer to customize most of the behaviors and animations, with excellent performance and a touch effect package that can be controlled externally.

`In conclusion, using this package enables easy definition of flexible touch behaviors or touch animation.`

## View
![ezgif-5-2ec16f8df8](https://github.com/MTtankkeo/Flutter_Touch_Ripple/assets/122026021/54ef9092-2dcb-45e9-b2cf-03b03a1296eb)



## How to apply ripple widget

Please referance to this code!

```dart
TouchRipple(
    onTap: () => print('Hello World!'),
    child: ... // <- this your widget!
),
```

Referance to the appropriate code to implement page movement with this code

```dart
TouchRipple(
    onTap: () {
        HapticFeedback.selectionClick();
        onTap?.call();
    },
    // or behavior
    tapBehavior: const TouchRippleBehavior(
        // "The spread animation must complete in order for the registered
        // event callback function to be called." which is equivalent to defining
        eventCallBackableMinPercent: 1,
    ),
);
```

## Apply eventCallBackableMinPercent = 1
When defining the argument ___eventCallBackableMinPercent___ of the above [TouchRippleBehavior] to be 1, we can implement a behavior to move the page after the touch ripple effect is complete.

![ezgif-2-af1eff8e7e](https://github.com/MTtankkeo/Flutter_Touch_Ripple/assets/122026021/f92af980-3c44-4882-9e47-57b67739b8b5)

- - -

## properties of TouchRipple Widget

| Properie | Description | Default value | Type
| ------ | ------ | ------ | ------
| child | The [child] widget contained by the [TouchRipple] widget. | required | Widget
| onTap | Defines a function that is called when the user taps on that widget. | null | TouchRippleEventCallBack
| onDoubleTap | Defines a function that is called when the user double taps on that widget. | null | TouchRippleEventCallBack
| onDoubleTapContinuableChecked | ... | null | TouchRippleContinuableCheckedCallBack
| onDoubleTapStart | Defines a function that is called when a double tap event occurs and enters the double tap state. | null | TouchRippleStateCallBack
| onDoubleTapEnd | Defines a function that is called when a double tap event is fired and the double tap state has ended. | null | TouchRippleStateCallBack
| onLongTap | Defines a function that is called when the user long tap on that widget. | null | TouchRippleContinuableCheckedCallBack
| onLongTapStart | Defines a function that is called when a long tap event occurs and enters the long tap state. | null | TouchRippleStateCallBack
| onLongTapEnd | Defines a function that is called when a long tap event is fired and the long tap state has ended. | null | TouchRippleStateCallBack
| onHoverStart | Defines a function that is called when a hover event occurs and enters the hover state. | null | TouchRippleStateCallBack
| onHoverEnd | Defines a function that is called when the hover state ends. | null | TouchRippleStateCallBack
| onFocusStart | Defines a callback function that is called when the transitions to the focus state, The focus state is a state in which the gesture can continue to detect and process pointers. For example, a double tap state can be defined as a state in which the widget continues to detect the pointer and define the gesture continuously. | null | TouchRippleStateCallBack
| onFocusEnd | Defines a callback function that is called when the focus state ends, The focus state is a state in which the gesture can continue to detect and process pointers. For example, a double tap state can be defined as a state in which the widget continues to detect the pointer and define the gesture continuously. | null | TouchRippleStateCallBack
| behavior | Defines the default behavior of touch ripple all event. See also: If an behavior is not defined in the tap, double tap, or long tap events, it will be defined as the value defined for that behavior. | null | TouchRippleBehavior
| tapBehavior | Defines the behavior applied when a tap event occurs. | null | TouchRippleBehavior
| doubleTapBehavior | Defines the behavior applied when a double tap event occurs. | null | TouchRippleBehavior
| longTapBehavior | Defines the behavior applied when a long tap event occurs. | null | TouchRippleBehavior
| isDoubleTapContinuable | Defines whether double tapping is allowed in succession. | true | bool
| isLongTapContinuable | Defines whether long tapping is allowed in succession. | true | bool
| rejectBehavior | Defines the touch ripple reject with pointer position behavior. | TouchRippleRejectBehavior.leave | TouchRippleRejectBehavior
| cancelledBehavior | Defines the behavior that causes the gesture to be cancelled. | TouchRippleCancelledBehavior.none | TouchRippleCancelledBehavior
| longTapFocusStartEvent | ... | TouchRippleLongTapFocusStartEvent.onRejectable | TouchRippleLongTapFocusStartEvent
| rippleColor | Defines touch ripple background color of all events. | getter defaultRippleColor | Color
| hoverColor | Defines the background color of the hover effect shown when the mouse hovers. | null | Color
| hoverFadeInDuration | Defines fade-in duration of hover animatin. | null | Duration
| hoverFadeInCurve | Defines fade-in curve of hover curved animatin. | null | Curve
| hoverFadeOutDuration | Defines fade-out duration of hover animatin. | null | Duration
| hoverFadeOutCurve | Defines fade-out curve of hover curved animatin. | null | Curve
| rippleScale | Defines scale of touch ripple effect size. | 1 | double (1~max)
| tapableDuration | [tapableDuration] defines the duration after which the tap event is canceled after the pointerDown event occurs, In other words, in order to detect the point and have the tap event occur, the tap event must occur before the [tapableDuration]. | null | Duration
| renderOrder | Defines the order in which the touch ripple effect is drawn. | TouchRippleRenderOrderType.foreground | TouchRippleRenderOrderType
| hitTestBehavior | Same as [HitTestBehavior] of [RawGestureDetector]. | HitTestBehavior.translucent | HitTestBehavior
| doubleTappableDuration | The duration between two taps that is considered a double tap, This refers to the time interval used to recognize double taps, If a tap occurs and a tap occurs again before [doubleTappableDuration], it is considered a double tap. | const Duration(milliseconds: 250) | Duration
| doubleTapHoldDuration | Defines the minimum duration to end the double tap state. If a double tap state starts and no tap events occur during that duration, the double tap state ends. | null | Duration
| longTappableDuration | Defines the minimum duration define as a long tap. See also: A pointer down event is defined as a long tap when it occurs and a duration of [longTappableDuration] or more has elapsed. If the value is not defined, it is replaced by the spread duration of the long tap behavior. | const Duration(milliseconds: 750) | Duration
| longTapStartDeleyDuration | Defines the amount of duration that must elapse before a long press gesture is considered initiated. See also: For example if that value is defined as 500 milliseconds, the long press action is not considered to have started until the user has held down the widget for at least 500 milliseconds. | const Duration(milliseconds: 150) | Duration
| tapPreviewMinDuration | The minimum duration to wait before showing the preview tap effect, if no other events need to be considered. | const Duration(milliseconds: 150) | Duration
| controller | This is the controller you define when you need to manage touch ripple effects externally. | null | TouchRippleController
| borderRadius | Same as [BorderRadius] of [ClipRRect]. | BorderRadius.zero | TouchRippleController
| hoverCursor | Defines the mouse cursor that is visible when hovering with the mouse. | SystemMouseCursors.click | SystemMouseCursor
| hoverColorRelativeOpacity | Defines what percentage of ripple color opacity the default hover color will be defined as when no hover color is artificially defined. | 0.4 | double
| focusColorRelativeOpacity | Defines what percentage of ripple color opacity the default focus color will be defined as when no focus color is artificially defined. | 0.4 | double
| useHoverEffect | Defines whether a hover effect should be used throughout. | true | bool
| useFocusEffect | Defines whether a focus effect should be used throughout. | true | bool
| focusColor | Defines the background colour of the focus effect that occurs on focus. | null | Color
| focusFadeInDuration | Defines fade-in duration of focus animatin. | const Duration(milliseconds: 150) | Duration
| focusFadeInCurve | Defines fade-in curve of focus curved animatin. | Curves.easeOut | Curve
| focusFadeOutDuration | Defines fade-out duration of focus animatin. | null | Duration
| focusFadeOutCurve | Defines fade-out curve of focus curved animatin. | null | Curve
| useDoubleTapFocusEffect | Defines whether to use the focus effect on double tap state. | true | bool
| useLongTapFocusEffect | Defines whether to use the focus effect on long tap state. | true | bool
| isOnHoveredDisableFocusEffect | Defines whether to disable the focus effect when in a hover state. | false | bool

## properties of TouchRippleBehavior

See also: Because this values is flexible and interacts with multiple values, we were unable to document a default value.

| Properie | Description | Type
| ------ | ------ | ------
| overlap | Defines the behavior when the effect is overlapped. | TouchRippleOverlapBehavior
| lowerPercent | Defines in decimal form ranging from 0 to 1, at what point the spread animation of the touch ripple effect will be started. | double (0~1)
| upperPercent | Defines in decimal form ranging from 0 to 1, at what point the spread animation of the touch ripple effect will be ended. | double (0~1)
| fadeLowerPercent | Defines in decimal form ranging from 0 to 1, at what point the fade animation of the touch ripple effect will be started. | double (0~1)
| fadeUpperPercent | Defines in decimal form ranging from 0 to 1, at what point the fade animation of the touch ripple effect will be ended. | double (0~1)
| eventCallBackableMinPercent | Defines the point in the spread animation of the touch ripple effect when the registered event callback function can be called. For example, if the user is about to click to move the page, you don't want the event callback function to be called before the effect has fully spread, causing the page to move. | double
| spreadDuration | Defines the duration of the touch ripple spread animation. | Duration
| spreadCurve | Defines the curve of the touch ripple spread curved animation. | Curve
| fadeInDuration | Defines the duration of the touch ripple fade-in of fade animation. | Duration
| fadeInCurve | Defines the curve of the touch ripple fade-in of fade curved animation. | Curve
| fadeOutDuration | Defines the duration of the touch ripple fade-out of fade animation. | Duration
| fadeOutCurve | Defines the curve of the touch ripple fade-out of fade curved animation. | Curve
| canceledDuration | Defines the duration for the touch ripple effect to fade out when it is interrupted by a touch ripple overlap behavior. | Duration
| canceledDuration | Defines the duration for the touch ripple effect to fade out when it is interrupted by a touch ripple overlap behavior. | Duration
| canceledCurve | Defines the curve of the fade out curve animation when the touch ripple effect is cancelled midway by the touch ripple overlap behavior. | Curve

- - -

## Values of TouchRippleOverlapBehavior

This enum is used to defines the behavior of a touch ripple when it overlaps.

| Properie | Description
| ------ | ------
| overlappable | Defines that the touch ripples should overlap.
| cancel | If the effects overlap, the previous touch effect will be canceled and the should be added to the stack will be added.
| ignoring | If the effects overlap, ignore and cancel the event until the previous touch effect disappears.

## Apply TouchRippleRejectBehavior.overlappable
![ezgif-2-29d7de7115](https://github.com/MTtankkeo/Flutter_Touch_Ripple/assets/122026021/ef9f3e13-f2f0-4e49-b83b-b3fdc990e3c4)

## Apply TouchRippleRejectBehavior.cancel
![ezgif-2-5f471041ff](https://github.com/MTtankkeo/Flutter_Touch_Ripple/assets/122026021/bba89ffa-2767-4390-99d7-24e5ca96110d)

## Apply TouchRippleRejectBehavior.ignoring
![ezgif-2-6f60071360](https://github.com/MTtankkeo/Flutter_Touch_Ripple/assets/122026021/2339cbc4-a20a-4fc6-a402-1202d4d35f0a)

- - -

## Values of TouchRippleRejectBehavior

This enum is defines behavior for which the gesture is rejected.

| Properie | Description
| ------ | ------
| touchSlop | Once the pointer is detected, the event is canceled if the pointer movement distance is greater than or equal to [kTouchSlop].
| leave | Once the pointer is detected, the event is canceled if the pointer position is outside the position occupied by the widget.

## Apply TouchRippleRejectBehavior.touchSlop
![ezgif-5-d5e8cb93e2](https://github.com/MTtankkeo/Flutter_Touch_Ripple/assets/122026021/2ca71a34-e30e-4b8f-81f4-f58890f725d0)
 
## Apply TouchRippleRejectBehavior.leave
![ezgif-5-63fc65bd9f](https://github.com/MTtankkeo/Flutter_Touch_Ripple/assets/122026021/245c7095-29af-4b55-8f22-f453f771d70f)

- - -

## Values of TouchRippleCancelledBehavior 

This enum is defines the task when the gesture is cancelled.

| Value | Description
| ------ | ------
| none | No specific task is performed when the gesture is canceled.
| stopSpread | The spread animation of the touch ripple effect is stopped when the gesture is canceled.
| reverseSpread | The spread animation of the touch ripple effect is reversed when the gesture is canceled.

## Apply TouchRippleCancelBehavior.none
![ezgif-1-8b40a9458c](https://github.com/MTtankkeo/Flutter_Touch_Ripple/assets/122026021/0f70fc9b-31d4-44f6-9cfa-aa976ec2377f)

## Apply TouchRippleCancelBehavior.stopSpread
![ezgif-1-61b8e1cf2c](https://github.com/MTtankkeo/Flutter_Touch_Ripple/assets/122026021/8c62e1e5-0f78-4247-9120-b2e2d1c08b78)

## Apply TouchRippleCancelBehavior.reverseSpread
![ezgif-1-fe8e2bf8fa](https://github.com/MTtankkeo/Flutter_Touch_Ripple/assets/122026021/22e724a0-a838-4066-9801-8bb7e1606466)

- - -

## Values of TouchRippleLongTapFocusStartEvent 

| Value | Description
| ------ | ------
| onContinueStart | The considered to be in focus when it is in a continuable state.
| onRejectable | The situation that defines whether it is a long tap is considered the focus state.

## Apply TouchRippleCancelBehavior.onContinueStart
![ezgif-1-8ad43f2371](https://github.com/MTtankkeo/Flutter_Touch_Ripple/assets/122026021/b4fb9254-60f3-4726-b3ad-e673a6ea994a)

## Apply TouchRippleCancelBehavior.onRejectable
![ezgif-1-fafc42efee](https://github.com/MTtankkeo/Flutter_Touch_Ripple/assets/122026021/1adaec37-7ac4-4cde-9ecc-8d6f9b16b289)

- - -

## Values of TouchRippleRenderOrderType 

This enum is used to defines the render order of a touch ripple effects.

| Value | Description
| ------ | ------
| foreground | This value Defines that the touch ripple should be rendered in front of other elements
| background | This value Defines that the touch ripple should be rendered behind other elements.

## Apply TouchRippleCancelBehavior.foreground
![ezgif-1-ea7be44be2](https://github.com/MTtankkeo/Flutter_Touch_Ripple/assets/122026021/ac77426d-716c-4dcc-bdf2-9626eee49b9a)

## Apply TouchRippleCancelBehavior.background
![ezgif-1-add7f9a0d0](https://github.com/MTtankkeo/Flutter_Touch_Ripple/assets/122026021/07edafeb-27fe-4c37-83a8-5186241ddd0d)
