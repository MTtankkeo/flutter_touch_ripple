import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_animation.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_behavior.dart';

/// The mixin provides necessary information for gesture behaviors
/// and other rendering processes about the touch ripple effects.
mixin TouchRippleContext {
  /// Returns the instance of a [TickerProvider] for playing
  /// ripple effects and other animations.
  TickerProvider get vsync;

  /// Returns the instance of the build context for the widget for applying
  /// the ripple effect.
  BuildContext get context;

  /// Returns the background color of the spread ripple effect.
  Color get rippleColor;

  /// Returns the background color of the solid effect when a user hovers.
  Color get hoverColor;

  /// Returns the background color of the solid effect when a consecutive
  /// (e.g. about double-tap and long-tap) event state occurs.
  Color get focusColor;

  /// Returns the scale percentage value of a ripple effect and by default
  /// the origin position is center.
  double get rippleScale;

  /// Returns the radius pixels of a blur filter for spread ripple effect. It cannot
  /// be negative and as the value increases, the edge of the spread ripple effect
  /// becomes blurrier.
  double get rippleBlurRadius;

  /// Returns the instance of a border radius for a ripple effect. For reference,
  /// this option can be replaced with a widget like ClipRRect depending on
  /// the situation.
  BorderRadius get rippleBorderRadius;

  /// Returns the duration for which the ripple effect is previewed even if the gesture
  /// is not finalized, allowing the user to see the effect while the pointer is down or moving.
  Duration get previewDuration;

  /// Returns the duration after which the gesture is considered rejected if the pointer
  /// is still down and no tap is completed. If this duration elapses without
  /// a successful gesture, the gesture will be rejected.
  Duration get tappableDuration;

  /// Returns the minimum duration used to distinguish between a tap and a double-tap.
  /// If the user does not perform a second tap within this duration, it is considered
  /// just a single-tap.
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

  /// Returns the touch ripple behavior applied to the touch ripple
  /// effect for the horizontal dragging or the vertical dragging.
  TouchRippleBehavior get dragBehavior;

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

  /// Returns the enumeration defines when the focus of a touch ripple
  /// should start, specifying the priority based on timing conditions.
  TouchRippleFocusTiming get focusTiming;

  /// Returns the enumeration defines the starting point of a spread ripple effect,
  /// specifying the origin of the ripple based on the user interaction.
  TouchRippleOrigin get origin;

  /// Returns the enumeration defines the shape of the ripple effect based
  /// on the widget layout, specifying how the ripple appears visually.
  TouchRippleShape get shape;

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

/// The enumeration defines the starting point of a spread ripple effect,
/// specifying the origin of the ripple based on the user interaction.
enum TouchRippleOrigin {
  /// Sets the effect to originate from the point where the pointer-down.
  pointer_down,

  /// Sets the effect to originate from the point where the pointer-move.
  pointer_move,

  /// Sets the effect to originate from the center of the widget, regardless
  /// of the pointer's position.
  center,
}

/// The enumeration defines the shape of the ripple effect based on
/// the widget layout, specifying how the ripple appears visually.
enum TouchRippleShape {
  /// Sets the shape to a square that corresponds to the area occupied
  /// by the widget layout.
  normal,

  /// Sets the shape to a circle that remains within the bounds of 
  /// the widget layout.
  inner_circle,

  /// Sets the shape to a circle that extends beyond the bounds of 
  /// the widget layout.
  outer_circle,
}