## 0.0.1
* First varsion (Inefficient)

## 1.0.0
* Rewritten the all code
* modularised the code and relied on abstract classes.
* made it extensible by implementing the gesture detector used in the package.
* documented the code, and used efficient design patterns.

## 1.0.1
* Bug fixes varsion

## 1.0.2
* Updated package varsion (Optimised)

## 1.0.3
* Slightly updated version (For additional behaviors and gestures)

## 1.0.4
* Updated package varsion

## 1.0.5
* Bug fixes varsion

## 1.0.6
* Fixes a phenomenon that does not cancel when the focus is in the longPress state and when the focus is in the focus state.

## 1.1.0
* Added blur effect of touch ripple effect.

## 1.1.1 ~ 1.1.13
* bug fix.

## 1.1.14
* Changed the default spread curve to Curve.ease.

## 1.1.2
* Added onTapAsync, onTapAsyncStart, onTapAsyncEnd of touch ripple event.

## 2.0.0
- All code for greater flexibility and maintainability, and tested. Added a TouchRippleStyle inherited widget, similar to PrimaryScrollController. The gesture-recognizing widget was separated to render the touch ripple effect independently.

## 2.1.0
- Added `TouchRippleOrigin` enumeration to define the starting point of a spread ripple effect based on user interaction. It includes the following options:
  - `pointer_down`: The ripple starts from the point where the pointer touches down.
  - `pointer_move`: The ripple starts from the point where the pointer moves.
  - `center`: The ripple starts from the center of the widget, regardless of the pointer's position.