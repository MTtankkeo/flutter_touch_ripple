# Touch Ripple For Flutter
### 👁 Customizable touch ripple for flutter widget

This Flutter package allows developer to customize most of the behaviors and animations, with excellent performance and a touch effect package that can be controlled externally with randomness.

In conclusion, using this package enables easy definition of flexible touch behaviors or touch animation.

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
        eventCallBackableMinPercent: 1,
    ),
);
```

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
| cancelBehavior | Defines the behavior that causes the gesture to be cancelled. | TouchRippleCancelBehavior.none | TouchRippleCancelBehavior
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



## Values of TouchRippleOverlapBehavior

This enum is used to defines the behavior of a touch ripple when it overlaps.

| Properie | Description
| ------ | ------
| overlappable | Defines that the touch ripples should overlap.
| cancel | If the effects overlap, the previous touch effect will be canceled and the should be added to the stack will be added.
| ignoring | If the effects overlap, ignore and cancel the event until the previous touch effect disappears.



## Values of TouchRippleRejectBehavior

This enum is defines behavior for which the gesture is rejected.

| Properie | Description
| ------ | ------
| touchSlop | Once the pointer is detected, the event is canceled if the pointer movement distance is greater than or equal to [kTouchSlop].
| leave | Once the pointer is detected, the event is canceled if the pointer position is outside the position occupied by the widget.

## Applied TouchRippleRejectBehavior.touchSlop
![ezgif-5-d5e8cb93e2](https://github.com/MTtankkeo/Flutter_Touch_Ripple/assets/122026021/2ca71a34-e30e-4b8f-81f4-f58890f725d0)

## Applied TouchRippleRejectBehavior.leave
![ezgif-5-63fc65bd9f](https://github.com/MTtankkeo/Flutter_Touch_Ripple/assets/122026021/245c7095-29af-4b55-8f22-f453f771d70f)



## Values of TouchRippleCancelBehavior 

This enum is defines the task when the gesture is cancelled.

| Value | Description
| ------ | ------
| none | No specific task is performed when the gesture is canceled.
| stopSpread | The spread animation of the touch ripple effect is stopped when the gesture is canceled.
| reverseSpread | The spread animation of the touch ripple effect is reversed when the gesture is canceled.



## Values of TouchRippleLongTapFocusStartEvent 

| Value | Description
| ------ | ------
| onContinueStart | The considered to be in focus when it is in a continuable state.
| onRejectable | The situation that defines whether it is a long tap is considered the focus state.



## Values of TouchRippleLongTapFocusStartEvent 

This enum is used to defines the render order of a touch ripple effects.

| Value | Description
| ------ | ------
| foreground | This value Defines that the touch ripple should be rendered in front of other elements
| background | This value Defines that the touch ripple should be rendered behind other elements.
