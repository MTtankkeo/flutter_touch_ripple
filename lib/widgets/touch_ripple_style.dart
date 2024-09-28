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
    this.focusColor,
    this.rippleScale,
    this.rippleBlurRadius,
    this.rippleBorderRadius,
    this.previewDuration,
    this.tappableDuration,
    this.doubleTappableDuration,
    this.doubleTapAliveDuration,
    this.longTappableDuration,
    this.longTapCycleDuration,
    this.tapBehavior,
    this.doubleTapBehavior,
    this.longTapBehavior,
    this.rejectBehavior,
    this.overlapBehavior,
    this.renderOrderType,
    this.useHoverEffect,
    this.useFocusEffect,
    this.onlyMainButton
  });

  /// The value defines the background color of a spread ripple effect.
  final Color? rippleColor;

  /// The value defines the background color of a effect when the user hovers.
  final Color? hoverColor;

  /// The value defines the background color of the solid effect when a
  /// consecutive (e.g. about double-tap and long-tap) event state occurs.
  final Color? focusColor;

  /// The value defines the scale percentage value of a ripple effect.
  final double? rippleScale;

  /// The value defines the radius pixels of a blur filter to touch ripple.
  final double? rippleBlurRadius;

  /// The value defines the instance of a border radius for a ripple effect.
  final BorderRadius? rippleBorderRadius;

  /// The value defines the touch ripple behavior applied to the touch ripple
  /// effect for tapped or clicked.
  final TouchRippleBehavior? tapBehavior;

  /// The value defines the touch ripple behavior applied to the touch ripple
  /// effect for double tapped or double clicked.
  final TouchRippleBehavior? doubleTapBehavior;

  /// The value defines the touch ripple behavior applied to the touch ripple
  /// effect for long tapped or long pressed and long clicked.
  final TouchRippleBehavior? longTapBehavior;

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

  /// The value defines the duration until double-tap deactivation. During
  /// this period, any single tap is still considered a double-tap without
  /// requiring continuous double-tapping.
  final Duration? doubleTapAliveDuration;

  /// The value defines the minimum duration used to distinguish between a tap and
  /// a long-tap. After this duration has passed, the long-tap effect starts to be
  /// displayed to the user.
  final Duration? longTappableDuration;

  /// The value defines the duration until long-tap reactivation. After this period,
  /// any pointer down and move is still considered a long-tap without requiring
  /// the continuous process of pointer-up followed by pointer-down.
  final Duration? longTapCycleDuration;

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

  /// The value defines whether the hover effect is enabled for touch ripple
  /// animations. If true, a solid hover effect is applied when the user hovers.
  final bool? useHoverEffect;

  /// The value defines whether the focus effect is enabled for touch ripple
  /// animations. If true, a solid focus color effect is applied for
  /// consecutive events like double-tap and long-tap or others.
  final bool? useFocusEffect;

  /// The value defines the boolean that is whether only the main button is recognized
  /// as a gesture when the user that is using mouse device clicks on the widget.
  final bool? onlyMainButton;

  /// Returns the [TouchRippleStyle] most closely associated with the given
  /// context, and returns null if there is no [ScrollController] associated
  /// with the given context.
  static TouchRippleStyle? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TouchRippleStyle>();
  }

  @override
  bool updateShouldNotify(TouchRippleStyle oldWidget) {
    return rippleColor != oldWidget.rippleColor
        || hoverColor != oldWidget.hoverColor
        || focusColor != oldWidget.focusColor
        || rippleScale != oldWidget.rippleScale
        || rippleBlurRadius != oldWidget.rippleBlurRadius
        || rippleBorderRadius != oldWidget.rippleBorderRadius
        || tapBehavior != oldWidget.tapBehavior
        || previewDuration != oldWidget.previewDuration
        || tappableDuration != oldWidget.tappableDuration
        || doubleTappableDuration != oldWidget.doubleTappableDuration
        || doubleTapAliveDuration != oldWidget.doubleTapAliveDuration
        || longTappableDuration != oldWidget.longTappableDuration
        || longTapCycleDuration != oldWidget.longTapCycleDuration
        || rejectBehavior != oldWidget.rejectBehavior
        || overlapBehavior != oldWidget.overlapBehavior
        || renderOrderType != oldWidget.renderOrderType
        || useHoverEffect != oldWidget.useHoverEffect
        || useFocusEffect != oldWidget.useFocusEffect
        || onlyMainButton != oldWidget.onlyMainButton;
  }
}
