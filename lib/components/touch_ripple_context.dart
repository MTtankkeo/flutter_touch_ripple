import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_animation.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_behavior.dart';

/// The mixin provides necessary information for gesture behaviors
/// and other rendering processes about touch ripple.
mixin TouchRippleContext {
  /// Returns the instance of a [TickerProvider] for playing
  /// ripple effects and other animations.
  TickerProvider get vsync;

  /// Returns the background color of the spread ripple effect.
  Color get rippleColor;

  /// Returns the background color of the solid effect when a user hovers.
  Color get hoverColor;

  /// Returns the background color of the solid effect when a consecutive
  /// (e.g. about double-tap and long-tap) event state occurs.
  Color get focusColor;

  /// Returns the scale percentage value of the ripple effect.
  double get rippleScale;

  /// Return the radius pixels of a blur filter to the touch ripple.
  double get rippleBlurRadius;

  /// Return the instance of a border radius for the ripple effect.
  BorderRadius get rippleBorderRadius;

  /// Returns the duration for which the ripple effect is previewed
  /// even if the gesture is not finalized, allowing the user to see
  /// the effect while the pointer is down or moving.
  Duration get previewDuration;

  /// Returns the duration after which the gesture is considered
  /// rejected if the pointer is still down and no tap is completed.
  /// If this duration elapses without a successful gesture, the
  /// gesture will be rejected.
  Duration get tappableDuration;

  /// Returns the minimum duration used to distinguish between a tap and
  /// a double-tap. If the user does not perform a second tap within
  /// this duration, it is considered just a single-tap.
  Duration get doubleTappableDuration;

  /// Returns the duration until double-tap deactivation. During this period,
  /// any single tap is still considered a double-tap without requiring
  /// continuous double-tapping.
  Duration get doubleTapAliveDuration;

  /// Returns the minimum duration used to distinguish between a tap and
  /// a long-tap. After this duration has passed, the long-tap effect
  /// starts to be displayed to the user.
  Duration get longTappableDuration;

  /// Returns the duration until long-tap reactivation. After this period, any
  /// pointer down and move is still considered a long-tap without requiring
  /// the continuous process of pointer-up followed by pointer-down.
  Duration get longTapCycleDuration;

  /// Returns the touch ripple behavior applied to the touch ripple
  /// effect for tapped or clicked.
  TouchRippleBehavior get tapBehavior;

  /// Returns the touch ripple behavior applied to the touch ripple
  /// effect for double tapped or double clicked.
  TouchRippleBehavior get doubleTapBehavior;

  /// Returns the touch ripple behavior applied to the touch ripple
  /// effect for long tapped or long pressed and long clicked.
  TouchRippleBehavior get longTapBehavior;

  /// Returns the behavior that defines when a gesture should be rejected,
  /// specifying the conditions for rejection.
  TouchRippleRejectBehavior get rejectBehavior;

  /// Returns the behavior that defines the touch ripple spread animation
  /// when the touch ripple effect is canceled.
  TouchRippleCancelBehavior get cancelBehavior;

  /// Return the behavior of a touch ripple when it overlaps with
  /// other ripple effects. (e.g. overlappable, cancel, ignore)
  TouchRippleOverlapBehavior get overlapBehavior;

  /// Returns the instance of the fade animation for the touch ripple effect
  /// when the hover effect is triggered.
  TouchRippleAnimation get hoverAnimation;

  /// Returns the instance of the fade animation for the touch ripple effect
  /// when the focus effect is triggered.
  TouchRippleAnimation get focusAnimation;

  /// Returns the the enumeration defines when the focus of a touch ripple
  /// should start, specifying the priority based on timing conditions.
  TouchRippleFocusTiming get focusTiming;

  /// Returns whether the hover effect is enabled for touch ripple animations.
  /// If true, a solid hover effect is applied when the user hovers.
  bool get useHoverEffect;

  /// Returns whether the focus effect is enabled for touch ripple animations.
  /// If true, a solid focus color effect is applied for consecutive events
  /// like double-tap and long-tap or others.
  bool get useFocusEffect;
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

/// The enumeration defines the behavior that defines the touch ripple
/// spread animation when the touch ripple effect is canceled.
enum TouchRippleCancelBehavior {
  /// Sets the behavior to perform no action when the effect is canceled.
  none,
  /// Sets the behavior to stop the spread animation of the touch ripple
  /// effect when the effect is canceled.
  stop,
  /// Sets the behavior to reverse the spread animation of the touch ripple
  /// effect when the effect is canceled.
  reverse,
}

/// The enumeration defines the behavior of a touch ripple when
/// it overlaps with other ripple effects.
enum TouchRippleOverlapBehavior {
  /// Sets the touch ripples to be allowed to overlap with each other.
  overlappable,

  /// Sets the touch ripple to be canceled if the effects overlap,
  /// with the new effect being added to the stack.
  cancel,

  /// Sets the event to be ignored if the effects overlap,
  /// canceling the previous touch effect until it disappears.
  ignore,
}

/// The enumeration defines when the focus of a touch ripple should start,
/// specifying the priority based on timing conditions.
enum TouchRippleFocusTiming {
  /// Sets the focus event to start when the ripple is in a rejectable state,
  /// meaning the gesture has not yet been fully accepted, but the effect
  /// is visible and can be canceled.
  rejectable,

  /// Sets the focus event to start when multiple ripple effects occur in rapid
  /// succession. This setting prevents the focus from being triggered prematurely 
  /// when in a rejectable state.
  consecutive,
}