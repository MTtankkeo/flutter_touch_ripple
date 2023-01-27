# 💥 Flutter Touch Ripple 💥
### Customizable touch ripple for flutter widget

The package is develop similar to Android Touch Ripple.
also defines it easy and customize animations and features or behaviors.

### flutter pub
https://pub.dev/packages/flutter_touch_ripple

## How to apply ripple widget

Please referance to this code!

```dart
TouchRipple(
    onTap: () => print('Hello World!'),
    child: ... // <- This your widget!
),
```

Referance to the appropriate code to implement page movement with this code

```dart
TouchRipple(
    // Until the ripple effect end hold the call of the [Ripple.onTap],
    // Prevents the ripple effect from being invisible and page shifting.
    startOnTap: StartOnTap(isWait: true)
    child: ... // <- This your widget!
);
```

## properties of TouchRipple Widget

| Properies | Description | Default value | Type | Required
| ------ | ------ | ------ | ------ | ------
| child | The [child] contained by the ripple widget | null | Widget | true
| clipBehavior | clip of the [ClipRRect] contained by the ripple widget | Clip.hardEdge | Clip | false
| borderRadius | border radius of the [ClipRRect] contained by the ripple widget | BorderRadius.zero | BorderRadius | false
| rippleRadius | The border radius is referenced only by [RipplePainter] (ripple effect) | BorderRadius.zero | BorderRadius | false
| cursor | Mouse cursor when in hover state. | null | SystemMouseCursor? | false
| doubleTapBehavior | behavior when double tabs occur continuously. | DoubleTapBehavior.cancel | DoubleTapBehavior | false
| longPressBehavior | whether longpress can occur continuously. | LongPressBehavior.cancel | LongPressBehavior | false
| overlapBehavior | all event type behavior when a ripple effect needs to be displayed when the ripple effect is not complete. | RippleOverlapBehavior.cancel | RippleOverlapBehavior | false
| tapOverlapBehavior | tap event type behavior when a ripple effect needs to be displayed when the ripple effect is not complete. | overlapBehavior | RippleOverlapBehavior | false
| doubleTapOverlapBehavior | double tap event type behavior when a ripple effect needs to be displayed when the ripple effect is not complete | overlapBehavior | RippleOverlapBehavior | false
| startTapEffect | double tap event type behavior when a ripple effect needs to be displayed when the ripple effect is not complete | overlapBehavior | StartTapRippleEffect | false
| touchSlop | the distance at which the minimum pixel must be moved to accurately define the gesture | kTouchSlop | double | false
| isActive | Whether to use the ripple widget and all events | true | bool | false
| startOnTap | Define when [onTap] is called | StartOnEvent(isWait: false) | StartOnEvent | false
| startOnDoubleTap | Define when [onDoubleTap] is called | StartOnEvent(isWait: false) | StartOnEvent | false
| rippleColor | Ripple effect background color | const Color.fromRGBO(0, 0, 0, 0.4) | Color | false
| rippleColorTween | Ripple effect background color tween | null | ColorTween? | false
| longPressRippleColor | Ripple effect color in longpress staten | null | Color? | false
| longPressRippleColorTween | Ripple effect color tween in longpress state | null | ColorTween? | false
| foregroundColor | background color behind ripple effect | null | Color? | false
| foregroundColorTween | background color tween behind ripple effect | null | ColorTween? | false
| useEffect | Integrally define whether to use ripple-related effects | true | bool | false
| useTapEffect | Whether to use ripple effect when tap | useEffect | bool | false
| useDoubleTapEffect | Whether to use ripple effect when double tap | useEffect | bool | false
| useLongPressEffect | Whether to use ripple effect when longpress | useEffect | bool | false
| useForeground | Integrally define whether to use foreground. | false | bool | false
| useTapForeground | Whether to use foreground when tap | useForeground | bool | false
| useDoubleTapForeground | Whether to use foreground when double tap | useForeground | bool | false
| useLongPressForeground | Whether to use foreground when longpress | useForeground | bool | false
| lowerPercent | Integrally define the lower percent of different event types, Define the minimum spread of the ripple effect as a percent | 0.4 | double(0~1) | false
| upperPercent | Integrally define the upper percent of different event types, Define the maximum spread of the ripple effect as a percent | 1 | double(0~1) | false
| tapLowerPercent | The [lowerPercent] of tap ripple effect | lowerPercent | double(0~1) | false
| tapUpperPercent | The [upperPercent] of tap ripple effect | upperPercent | double(0~1) | false
| doubleTapLowerPercent | The [lowerPercent] of double tap ripple effect | lowerPercent | double(0~1) | false
| doubleTapUpperPercent | The [upperPercent] of double tap ripple effect | upperPercent | double(0~1) | false
| longPressLowerPercent | The [lowerPercent] of longpress ripple effect | lowerPercent | double(0~1) | false
| longPressUpperPercent | The [upperPercent] of longpress ripple effect | upperPercent | double(0~1) | false
| scale | The scale of ripple effect size | 1 | double(More than 0) | false
| tapScale | The [scale] of tap effect | scale | double(More than 0) | false
| doubleTapScale | The [scale] of double tap effect | scale | double(More than 0) | false
| longPressScale | TThe [scale] of longpress effect | scale | double(More than 0) | false
| durationScale | Duration speed scale | 1 | double | false
| rippleDuration | Spread duration of ripple effect. | const Duration(milliseconds: 150) | Duration | false
| rippleCurve | Animation curve of ripple effect | Curves.easeOut | Curve | false
| rippleFadeInDuration | Fade in animation of ripple effect | const Duration(milliseconds: 25) | Duration | false
| rippleFadeInCurve | Animation curve of ripple effect fade in(forward), Curved animation of [rippleFadeInDuration]. | Curves.easeOut | Curve | false
| rippleFadeOutDuration | Fade out animation of ripple effect | const Duration(milliseconds: 25) | Duration | false
| rippleFadeOutCurve | Animation curve of ripple effect fade out(reverse), Curved animation of [rippleFadeOutDuration] | Curves.easeIn | Curve | false
| canceledRippleDuration | Fade-out animation duration used when ripple effect are canceled by [touchSlop] and [RippleOverlapBehavior.cancel] | Duration.zero | Duration | false
| canceledRippleCurve | Animation curve of canceled ripple effect fade out(reverse), Curved animation of [canceledRippleDuration] | Curve.ease | Curve | false
| longPressDuration | Minimum duration to define whether it is tap or longpress | const Duration(seconds: 1) | Duration | false
| longPressCurve | Animation curve of longpress ripple effect(forward), Curved animation of [longPressDuration]. | Curves.linear | Curve | false
| longPressFadeInDuration | Fade-in animation duration of longpress ripple effect | longPressDuration | Duration | false
| longPressFadeInCurve | Animation curve of longpress ripple effect fade in(forward), Curved animation of [longPressFadeInDuration] | Curves.linear | Curve | false
| longPressFadeOutDuration | Fade-out animation duration of longpress ripple effect | const Duration(milliseconds: 100) | Duration | false
| longPressFadeOutCurve | Fade-out animation duration of longpress ripple effect | Curves.ease | Curve | false
| canceledLongPressDuration | Fade-out animation duration of canceled longpress ripple effect | Duration.zero | Duration | false
| foregroundFadeInDuration | Fade-in animation duration of foreground | const Duration(milliseconds: 150) | Duration | false
| foregroundFadeInCurve | Animation curve of foreground fade in(forward), Curved animation of [foregroundFadeInDuration] | const Duration(milliseconds: 150) | Curve | false
| foregroundFadeOutDuration | Fade-out animation duration of foreground | const Duration(milliseconds: 150) | Duration | false
| foregroundFadeOutCurve | Animation curve of foreground fade out(reverse), Curved animation of [foregroundFadeOutDuration] | Curves.easeIn | Curve | false
| canceledForegroundDuration | Fade-out animation duration of canceled foreground | Duration.zero | Duration | false
| canceledForegroundCurve | Animation curve of canceled foreground fade out(reverse), Curved animation of [foregroundFadeOutDuration] | Curves.easeIn | Curve | false
| onTap | When one (click or touch), See also use [StartOnEvent] to delay call [onTap] | null | Function | true
| onDoubleTap | When double (click or touch) | null | Function? | false
| onDoubleTapStart | If the double tap has started | null | OnDoubleTap? | false
| onDoubleTapEnd | If the double tap state is canceled | null | Function? | false
| onLongPress | If the user continues to press for a certain period of time without lifting their hand | null | OnLongPress? | false
| onHover | Same as [Listener.onHover] | null | Function? | false
| onHoverStart | Same as [MouseRegion.onEnter] | null | Function? | false
| onHoverEnd | Same as [MouseRegion.onExit] | null | Function? | false
| onPointerDown | Same as [Listener.onPointerDown] | null | OnPointer? | false
| onPointerMove | Same as [Listener.onPointerMove] | null | OnPointer? | false
| onPointerUp | Same as [Listener.onPointerUp] | null | OnPointer? | false
| onPointerUp | Same as [Listener.onPointerUp] | null | OnPointer? | false
| onPointerCancel | Same as [Listener.onPointerCancel] | null | OnPointer? | false
| onCancel | ... | null | Function? | false
| tapableDuration | Minimum tapable duration based on pointer down | Duration.zero | Duration | false
| doubleTapStateDuration | Minimum duration to define whether it is a tap or double tap | const Duration(milliseconds: 250) | Duration | false
| doubleTapStateCancellationDuration | Minimum duration to enter the double tap state and cancel the state | const Duration(milliseconds: 500) | Duration | false
| startTapEffectDuration | Pointer down occurs and ripple effects occur only after a certain period of duration | const Duration(milliseconds: 100) | Duration | false







