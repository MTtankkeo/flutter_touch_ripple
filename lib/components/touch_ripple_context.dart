import 'package:flutter/widgets.dart';

mixin TouchRippleContext {
  /// Gets the background color of a spread ripple effect.
  Color get rippleColor;

  /// Gets the background color of a effect when the user hovers.
  Color get hoverColor;

  TouchRippleRejectBehavior get rejectBehavior;
}

/// This enumeration defines behavior for which the gesture is rejected.
enum TouchRippleRejectBehavior {
  /// No specific task is performed when the gesture is canceled.
  none,

  /// Once the pointer is detected, the event is canceled if the pointer
  /// movement distance is greater than or equal to [kTouchSlop].
  touchSlop,

  /// Once the pointer is detected, the event is canceled if the pointer position
  /// is outside the position occupied by the widget.
  leave,
}
