import 'package:flutter/widgets.dart';

/// The mixin provides necessary information for gesture behaviors
/// and other rendering processes about touch ripple.
mixin TouchRippleContext {
  /// Returns the instance of a [TickerProvider] for playing
  /// ripple effects and other animations.
  TickerProvider get vsync;

  /// Returns the background color of a spread ripple effect.
  Color get rippleColor;

  /// Returns the background color of a effect when the user hovers.
  Color get hoverColor;

  /// Returns the scale percentage value of a ripple effect.
  double get rippleScale;

  /// Return the instance of a border radius for a ripple effect.
  BorderRadius get rippleBorderRadius;

  /// Returns the behavior that defines when a gesture should be rejected,
  /// specifying the conditions for rejection.
  TouchRippleRejectBehavior get rejectBehavior;
}

/// The enumeration defines when a gesture should be rejected,
/// specifying the conditions for rejection.
enum TouchRippleRejectBehavior {
  /// Sets the gesture to not be rejected regardless of any action or event.
  /// However, if the gesture is forcibly rejected due to a scroll gesture,
  /// the rejection will occur as expected.
  none,

  /// Sets the gesture to be canceled if the pointer movement distance
  /// is greater than or equal to [kTouchSlop].
  touchSlop,

  /// Sets the gesture to be canceled if the pointer position is
  /// outside the area occupied by the widget.
  leave,
}
