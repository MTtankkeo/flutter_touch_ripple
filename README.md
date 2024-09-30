<div align="center">
    <img src="https://github.com/user-attachments/assets/3656c10c-6911-45bd-b035-ada85263b23a">
    <h1>Flutter Touch Ripple</h1>
    <table>
        <thead>
          <tr>
            <th>Version</th>
            <th>v2.0.1</th>
          </tr>
        </tbody>
    </table>
</div>

# Introduction
This Flutter package allows developer to customize most of the behaviors and animations, with excellent performance and a touch effect package that can be controlled externally.

| Event Type | Description | ♾️ Async | ♻️ Consecutive |
| ---------- | ----------- | ----- | ----------- |
| Tap        | When the user taps or clicks. | 🟢 | 🔴 |
| Double Tap | When the user double taps or double clicks. | 🔴 | 🟢 |
| Long Tap   | When the user long tap or long press. | 🔴 | 🟢 |
| Drag(V, H) | Not support yet. | 🟡 | 🟡 |

## Preview
The gif image below may appear distorted and choppy due to compression.

![preview](https://github.com/user-attachments/assets/2ddc204f-12d2-4c1e-b353-c7d11ebc6fc2)

## Usage
The following explains the basic usage of this package.

### How to apply the ripple effect?
Called when the user taps or clicks.

```dart
TouchRipple(
  onTap: () => print("Hello, World!"),
  child: ... // <- this your widget
)
```

### How to perform an async task?
```dart
TouchRipple<String>(
    onTapAsync: () async {
        return await Future.delayed(const Duration(milliseconds: 500), () {
            return "end";
        });
    },
    onTapAsyncStart: () => print("start"),
    onTapAsyncEnd: print,
    // ... skip
);
```

### How to define the style globally.
TouchRippleStyle defines the style of its descendant touch ripple widgets, similar to how PrimaryScrollController defines the controller for its descendant widgets.

```dart
TouchRippleStyle(
  rippleColor: Colors.blue.withAlpha(50),
  rippleBorderRadius: BorderRadius.circular(10),
  overlapBehavior: TouchRippleOverlapBehavior.ignore,
  cancelBehavior: TouchRippleCancelBehavior.none,
  onlyMainButton: false,
  tapBehavior: TouchRippleBehavior(...),
  child: ...
),
```

## The Properties of TouchRipple

| Name | Description | Type |
| ---- | ----------- | ---- |
| onTap | The callback function is called when the user taps or clicks. | VoidCallback?
| onTapAsync | The callback function is called when the user taps or clicks. but this function ensures that the touch ripple effect remains visible until the asynchronous operation is completed and prevents additional events during that time. | TouchRippleAsyncCallback\<T\>? |
| onTapAsyncStart | The callback function is called when an asynchronous operation is initiated by a tap. It provides the associated Future instance for the ongoing operation. | TouchRippleAsyncNotifyCallback\<T\>? |
| onTapAsyncEnd | The callback function is called when the result of the asynchronous operation is ready. It allows handling the result once the operation is complete. | TouchRippleAsyncResultCallback\<T\>? |
| onDoubleTap | The callback function is called when the user double taps or double clicks. | VoidCallback? |
| onDoubleTapConsecutive | The callback function is called to determine whether consecutive double taps should continue. It returns a [bool] indicating whether the long tap event should continue after the initial occurrence. | TouchRippleContinuableCallback? |
| onDoubleTapStart | The callback function is a lifecycle callback for the double-tap event. It is called when a double tap starts, which is useful for handling actions that occur during successive double taps. | VoidCallback? |
| onDoubleTapEnd | The callback function is a lifecycle callback for the double-tap event. It is called when a double tap ends, providing the advantage of knowing when a series of consecutive double taps has finished. | VoidCallback? |
| onLongTap | The callback function is called when the user long presses or long clicks. | TouchRippleContinuableCallback? |
| onLongTapStart | The callback function is a lifecycle callback for the long-tap event. It is called when a long tap starts, which is useful for initiating actions that require a sustained press. | VoidCallback? |
| onLongTapEnd | The callback function is a lifecycle callback for the long-tap event. It is called when a long tap ends, providing the advantage of knowing when a series of consecutive long taps has concluded. | VoidCallback? |
| onFocusStart | The callback function is a lifecycle callback for focus touch ripple events. It is called when a focus touch event starts, allowing for the initiation of actions based on the beginning of the focus event sequence. | VoidCallback? |
| onFocusEnd | The callback function is a lifecycle callback for focus touch ripple events. It is called when a focus touch event ends, providing the advantage of knowing when a series of focus touch ripple events has concluded. | VoidCallback? |
| onHoverStart | The callback function called when the cursor begins hovering over the widget. (by [MouseRegion]) This function allows for the initiation of actions based on the hover interaction. This function is not called in touch-based environments yet. | VoidCallback? |
| onHoverEnd | The callback function called when the cursor begins to leave the widget. (by [MouseRegion]) This function allows for actions to be executed based on the end of the hover interaction. This function is not called in touch-based environments yet. | VoidCallback? |
| hitBehavior | The behavior of hit testing for the child widget. | HitTestBehavior? |
| rippleColor | The background color of a spread ripple effect. | Color? |
| hoverColor | The background color of a effect when the user hovers. | Color? |
| focusColor | The background color of the solid effect when a consecutive (e.g. about double-tap and long-tap) event state occurs. | Color? |
| rippleScale | The scale percentage value of a ripple effect and by default the origin position is center. | double? |
| rippleBlurRadius | The radius pixels of a blur filter for spread ripple effect. It cannot be negative and as the value increases, the edge of the spread ripple effect becomes blurrier. | double? |
| rippleBorderRadius | The instance of a border radius for a ripple effect. For reference, this option can be replaced with a widget like [ClipRRect] depending on the situation. | BorderRadius? |
| previewDuration | The duration for which the ripple effect is previewed even if the gesture is not finalized, allowing the user to see the effect while the pointer is down or moving. | Duration? |
| tappableDuration | The duration after which the gesture is considered rejected if the pointer is still down and no tap is completed. If this duration elapses without a successful gesture, the gesture will be rejected. | Duration? |
| doubleTappableDuration | The minimum duration used to distinguish between a tap and a double-tap. If the user does not perform a second tap within this duration, it is considered just a single-tap. | Duration? |
| doubleTapAliveDuration | The duration until double-tap deactivation. During this period, any single tap is still considered a double-tap without requiring continuous double-tapping. | Duration? |
| longTappableDuration | The minimum duration used to distinguish between a tap and a long-tap. After this duration has passed, the long-tap effect starts to be displayed to the user. | Duration? |
| longTapCycleDuration | The duration until long-tap reactivation. After this period, any pointer down and move is still considered a long-tap without requiring the continuous process of pointer-up followed by pointer-down. | Duration? |
| tapBehavior | The touch ripple behavior applied to the touch ripple effect for tapped or clicked. | TouchRippleBehavior? |
| doubleTapBehavior | The touch ripple behavior applied to the touch ripple effect for double tapped or double clicked. | TouchRippleBehavior? |
| longTapBehavior | The touch ripple behavior applied to the touch ripple effect for long tapped or long pressed and long clicked. | TouchRippleBehavior? |
| rejectBehavior | The behavior that defines when a gesture should be rejected, specifying the conditions for rejection. | TouchRippleRejectBehavior? |
| cancelBehavior | The behavior that defines the touch ripple spread animation when the touch ripple effect is canceled. | TouchRippleCancelBehavior? |
| overlapBehavior | The behavior of a touch ripple when it overlaps with other ripple effects. (e.g. overlappable, cancel, ignore) | TouchRippleOverlapBehavior? |
| renderOrderType | The enumeration specifies the rendering order of the touch ripple effect, determining whether it should appear in the foreground or background. | TouchRippleRenderOrderType? |
| focusTiming | The enumeration defines when the focus of a touch ripple should start, specifying the priority based on timing conditions. | TouchRippleFocusTiming? |
| hoverAnimation | The instance of the fade animation for the touch ripple effect when the hover effect is triggered. | TouchRippleAnimation? |
| focusAnimation | The instance of the fade animation for the touch ripple effect when the focus effect is triggered. | TouchRippleAnimation? |
| onlyMainButton | The boolean that is whether only the main button is recognized as a gesture when the user that is using mouse device clicks on the widget. | bool? |
| useHoverEffect | Whether the hover effect is enabled for touch ripple animations. If true, a solid hover effect is applied when the user hovers. | bool? |
| useFocusEffect | Whether the focus effect is enabled for touch ripple animations. If true, a solid focus color effect is applied for consecutive events like double-tap and long-tap or others. | bool? |
| controller | The controller defines and manages states, listeners, a context and other values related to touch ripple, ensuring that each state exists uniquely within the controller. | TouchRippleController? |
| child | The widget that is target to apply touch ripple related effects. | Widget |

## The Properties of TouchRippleRejectBehavior
The enumeration defines when a gesture should be rejected, specifying the conditions for rejection.

| Name | Description |
| ---- | ----------- |
| none | Sets the gesture to not be rejected regardless of any action or event. However, if the gesture is forcibly rejected due to a scroll gesture, the rejection will occur as expected. |
| touchSlop | Sets the gesture to be canceled if the pointer movement distance is greater than or equal to [kTouchSlop]. |
| leave | Sets the gesture to be canceled if the pointer position is outside the area occupied by the widget. |

### When TouchRippleRejectBehavior.none
![none](https://github.com/user-attachments/assets/c9b791c6-c824-4b5c-9130-d18b99dc5eef)

### When TouchRippleRejectBehavior.touchSlop
![touchSlop](https://github.com/user-attachments/assets/446cab04-2bd2-4a30-8c57-5bd9526820c4)

### When TouchRippleRejectBehavior.leave
![leave](https://github.com/user-attachments/assets/91bcd5b3-1ef8-4130-a6f8-011ccc53f529)

## The Properties of TouchRippleOverlapBehavior
The enumeration defines the behavior of a touch ripple when it overlaps with other ripple effects.

| Name | Description |
| ---- | ----------- |
| overlappable | Sets the touch ripples to be allowed to overlap with each other. |
| cancel | Sets the touch ripple to be canceled if the effects overlap, with the new effect being added to the stack. |
| ignore | Sets the event to be ignored if the effects overlap, canceling the previous touch effect until it disappears. |

### When TouchRippleOverlapBehavior.overlappable
![overlappable](https://github.com/user-attachments/assets/be857c7a-a79d-47b3-95e0-00b14c0bbc02)

### When TouchRippleOverlapBehavior.cancel
![cancel](https://github.com/user-attachments/assets/f7f2fac2-b87b-4d96-8bd3-068e8e346a6e)

### When TouchRippleOverlapBehavior.ignore
![ignore](https://github.com/user-attachments/assets/467265e4-350f-4f2f-a71b-70f0ed0bf657)

## The Properties of TouchRippleCancelBehavior
The enumeration defines the behavior that defines the touch ripple spread animation when the touch ripple effect is canceled.

| Name | Description |
| ---- | ----------- |
| none | Sets the behavior to perform no action when the effect is canceled. |
| stop | Sets the behavior to stop the spread animation of the touch ripple effect when the effect is canceled. |
| reverse | Sets the behavior to reverse the spread animation of the touch ripple effect when the effect is canceled. |

### When TouchRippleCancelBehavior.none
![none](https://github.com/user-attachments/assets/bed7716d-0b1c-4c7c-a1c2-99d2d9b0aac1)

### When TouchRippleCancelBehavior.stop
![stop](https://github.com/user-attachments/assets/7822a182-a068-4011-8ac8-16f9e4d288ed)

### When TouchRippleCancelBehavior.reverse
![reverse](https://github.com/user-attachments/assets/6ad1cef6-17cb-4e9b-95b6-7fcc5dd3ad2e)

## The Properties of TouchRippleFocusTiming
The enumeration defines when the focus of a touch ripple should start, specifying the priority based on timing conditions.

| Name | Description |
| ---- | ----------- |
| rejectable | Sets the focus event to start when the ripple is in a rejectable state, meaning the gesture has not yet been fully accepted, but the effect is visible and can be canceled. |
| consecutive | Sets the focus event to start when multiple ripple effects occur in rapid succession. This setting prevents the focus from being triggered prematurely when in a rejectable state. |

### When TouchRippleFocusTiming.rejectable
![rejectable](https://github.com/user-attachments/assets/08cbed37-100a-42dc-a4cd-2126eeeb73a7)

### When TouchRippleFocusTiming.consecutive
![consecutive](https://github.com/user-attachments/assets/6e262eda-3d80-4b71-8b90-6af6a45bb6c3)

## The Properties of TouchRippleRenderOrderType
The enumeration specifies the rendering order of the touch ripple effect, determining whether it should appear in the foreground or background.

| Name | Description |
| ---- | ----------- |
| foreground | Sets the behavior to draw the touch ripple in the foreground, meaning it will appear above all other visual widgets in the interface. |
| background | Sets the behavior to draw the touch ripple in the background, ensuring it appears beneath all other visual widgets in the interface. |

### When TouchRippleRenderOrderType.foreground
![foreground](https://github.com/user-attachments/assets/544059c6-5859-40d7-995d-067d731ff10f)

### When TouchRippleRenderOrderType.background
![background](https://github.com/user-attachments/assets/5e61b4a6-943f-4818-9bb7-13c9e4dc24bf)
