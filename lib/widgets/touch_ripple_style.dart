import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_behavior.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_context.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple_render.dart';

/// This inherited widget globally provides the style information for
/// touch ripple effects to all descendant widgets in the widget tree.
class TouchRippleStyle extends InheritedWidget {
  const TouchRippleStyle({
    super.key,
    required super.child,
    this.rippleColor,
    this.hoverColor,
    this.rippleScale,
    this.rippleBlurRadius,
    this.rippleBorderRadius,
    this.previewDuration,
    this.tappableDuration,
    this.doubleTappableDuration,
    this.doubleTapAliveDuration,
    this.tapBehavior,
    this.rejectBehavior,
    this.overlapBehavior,
    this.renderOrderType
  });

  /// The value defines the background color of a spread ripple effect.
  final Color? rippleColor;

  /// The value defines the background color of a effect when the user hovers.
  final Color? hoverColor;

  /// The value defines the scale percentage value of a ripple effect.
  final double? rippleScale;

  /// The value defines the radius pixels of a blur filter to touch ripple.
  final double? rippleBlurRadius;

  /// The value defines the instance of a border radius for a ripple effect.
  final BorderRadius? rippleBorderRadius;

  /// The value defines the behavior applied to the touch ripple effect when tapped.
  final TouchRippleBehavior? tapBehavior;

  /// The value defines the duration for which the ripple effect is previewed
  /// even if the gesture is not finalized, allowing the user to see
  /// the effect while the pointer is down or moving.
  final Duration? previewDuration;

  /// The value defines the duration after which the gesture is considered
  /// rejected if the pointer is still down and no tap is completed.
  /// If this duration elapses without a successful gesture, the
  /// gesture will be rejected.
  final Duration? tappableDuration;

  /// The value defines the minimum duration used to distinguish between a tap and
  /// a double-tap. If the user does not perform a second tap within this duration,
  /// it is considered just a single-tap.
  final Duration? doubleTappableDuration;

  /// The duration until double-tap deactivation. During this period,
  /// any single tap is still considered a double-tap without requiring
  /// continuous double-tapping.
  /// 
  /// See Also, If the callback returns false, the duration will not be utilized,
  final Duration? doubleTapAliveDuration;

  /// The value defines the behavior that defines when a gesture should be
  /// rejected, specifying the conditions for rejection.
  final TouchRippleRejectBehavior? rejectBehavior;

  /// The value defines the behavior of a touch ripple when it overlaps
  /// with other ripple effects. (e.g. overlappable, cancel, ignore)
  final TouchRippleOverlapBehavior? overlapBehavior;

  /// The value defines the enumeration specifies the rendering order of
  /// the touch ripple effect, determining whether it should appear
  /// in the foreground or background.
  final TouchRippleRenderOrderType? renderOrderType;

  /// Returns the [TouchRippleStyle] most closely associated with the given
  /// context, and returns null if there is no [ScrollController] associated
  /// with the given context.
  static TouchRippleStyle? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TouchRippleStyle>();
  }

  @override
  bool updateShouldNotify(TouchRippleStyle oldWidget) {
    return rippleColor != oldWidget.rippleColor || hoverColor != oldWidget.hoverColor;
  }
}
