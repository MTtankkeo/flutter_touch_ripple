## 0.0.1
- First varsion (Inefficient)

## 1.0.0
- Rewritten the all code
- modularised the code and relied on abstract classes.
- made it extensible by implementing the gesture detector used in the package.
- documented the code, and used efficient design patterns.

## 1.0.1
- Bug fixes varsion

## 1.0.2
- Updated package varsion (Optimised)

## 1.0.3
- Slightly updated version (For additional behaviors and gestures)

## 1.0.4
- Updated package varsion

## 1.0.5
- Bug fixes varsion

## 1.0.6
- Fixes a phenomenon that does not cancel when the focus is in the longPress state and when the focus is in the focus state.

## 1.1.0
- Added blur effect of touch ripple effect.

## 1.1.1 ~ 1.1.13
- bug fix.

## 1.1.14
- Changed the default spread curve to Curve.ease.

## 1.1.2
- Added onTapAsync, onTapAsyncStart, onTapAsyncEnd of touch ripple event.

## 2.0.0
- All code for greater flexibility and maintainability, and tested. Added a TouchRippleStyle inherited widget, similar to PrimaryScrollController. The gesture-recognizing widget was separated to render the touch ripple effect independently.

## 2.1.0
- Added `TouchRippleOrigin` enumeration to define the starting point of a spread ripple effect based on user interaction. It includes the following options:
  - `pointer_down`: The ripple starts from the point where the pointer touches down.
  - `pointer_move`: The ripple starts from the point where the pointer moves.
  - `center`: The ripple starts from the center of the widget, regardless of the pointer's position.

## 2.2.0
- Changed the opacity of the default ripple color from `0.2` to `0.1`.

- Changed the default TouchRippleRenderOrderType value from `TouchRippleRenderOrderType.background` to `TouchRippleRenderOrderType.foreground`.

- Added `TouchRippleShape` enumeration defines the shape of the ripple effect based on the widget layout, specifying how the ripple appears visually. It includes the following options:
  - `normal`: The shape to a square that corresponds to the area occupied by the widget layout.
  - `inner_circle`: The shape to a circle that remains within the bounds of the widget layout.
  - `outer_circle`: The shape to a circle that extends beyond the bounds of the widget layout.

## 2.2.2
- Fixed an issue about [issues/1](https://github.com/MTtankkeo/flutter_touch_ripple/issues/1) for the null-safety exception about RenderBox reference.

## 2.2.3 ~ 2.2.32
- Fixed an issue related to [issues/1](https://github.com/MTtankkeo/flutter_touch_ripple/issues/1) for the 'Null check operator used on a null value' exception by adopting a verification approach to ensure necessary instances are initialized.

## 2.3.0
- Added the `TouchRipplePointerListener` widget for the nested gestures.

- Fixed an issue where the tap effect preview would also occur in parent widgets in a nested touch ripple environment. For more details, refer to the `TouchRipplePointerListener` widget.

- Fixed issues arising from incorrect code logic during the previous exception handling process, where rejection occurred at the wrong time (such as the pointer being rejected before leaving the widget's area).

## 2.3.1
- Modify the default hit behavior of the touch ripple from `HitTestBehavior.translucent` to `HitTestBehavior.opaque`.

## 2.4.0
- Added `TouchRippleDragGestureRecognizer` class for the drag gesture event about touch ripple.

- Added `onDragHorizontal` property in TouchRipple widget because the horizontal drag gesture event has been introduced, along with lifecycle callback functions such as `onDragHorizontalStart` and `onDragHorizontalEnd`.

- Added `onDragVertical` property in TouchRipple widget because the vertical drag gesture event has been introduced, along with lifecycle callback functions such as `onDragVerticalStart` and `onDragVerticalEnd`.

- Added `dragBehavior` property in TouchRipple widget and TouchRippleStyle.

## 2.4.1
- Fixed an issue where the previous effect was not reused when rejectable, causing a visual discontinuity.

## 2.5.0
- Fixed about the blur radius of the touch ripple effect.

- Added `TouchRippleBlur` to define the blur radius of the touch ripple effect dynamically.

- Added `MaterialTouchRippleBlur`, which provides both fixed and percentage-based blur radius options.

## 2.6.0
- Fixed an issue by delaying the definition of `GestureRecognizerBuilder` in the `TouchRippleGestureDetector` widget to the next frame after the build, rather than before the build, to increase flexibility and reduce potential exceptions.

- Added `ripplePadding` property that is the value of the padding of the ripple effect in TouchRipple widget and TouchRippleStyle, TouchRippleContext. In other words, it defines how much larger it can be to the outside than its the intrinsic size.

## 2.6.1
- Fixed an issue with the assertion exception related to `eventCallBackableMinPercent` in longTapBehavior.