import 'package:flutter/animation.dart';

/// This data class defines the configuration for a touch ripple effect,
/// including animation durations, curves, and spread/fade percentages.
///
/// This allows for customization of how the ripple effect behaves,
/// such as the timing and extent of spread, fade-in, fade-out,
/// and event callback triggering.
class TouchRippleBehavior {
  const TouchRippleBehavior({
    this.spreadDuration,
    this.spreadCurve,
    this.fadeInDuration,
    this.fadeInCurve,
    this.fadeOutDuration,
    this.fadeOutCurve,
    this.cancelDuration,
    this.cancelCurve,
    this.lowerPercent,
    this.upperPercent,
    this.fadeLowerPercent,
    this.fadeUpperPercent,
    this.eventCallBackableMinPercent
  }) : assert(lowerPercent != null ? lowerPercent >= 0 && lowerPercent <= 1 : true),
       assert(upperPercent != null ? upperPercent >= 0 && upperPercent <= 1 : true),
       assert(fadeLowerPercent != null ? fadeLowerPercent >= 0 && fadeLowerPercent <= 1 : true),
       assert(fadeUpperPercent != null ? fadeUpperPercent >= 0 && fadeUpperPercent <= 1 : true);

  /// The duration of a touch ripple spreading animation.
  final Duration? spreadDuration;

  /// The curve of a touch ripple spreading curved animation.
  final Curve? spreadCurve;

  /// The duration of the fade-in animation for a touch ripple effect.
  final Duration? fadeInDuration;

  /// The curve of the fade-in animation for a touch ripple effect.
  final Curve? fadeInCurve;

  /// The duration of the fade-out animation for a touch ripple effect.
  final Duration? fadeOutDuration;

  /// The curve of the fade-out animation for a touch ripple effect.
  final Curve? fadeOutCurve;

  /// The duration of the fade-out animation about cancel for a touch ripple effect.
  final Duration? cancelDuration;

  /// The curve of the fade-out animation about cancel for a touch ripple effect.
  final Curve? cancelCurve;

  /// The percentage value of the minimum spread ratio for a touch ripple effect.
  final double? lowerPercent;

  /// The percentage value of the maximum spread ratio for a touch ripple effect.
  final double? upperPercent;

  /// The percentage value of the minimum fade ratio for the touch ripple effect.
  final double? fadeLowerPercent;

  /// The percentage value of the maximum fade ratio for the touch ripple effect.
  final double? fadeUpperPercent;

  /// The minimum percentage of spread at which the event callback is triggered.
  /// For example, if set to 0.5, the callback is invoked when the ripple effect
  /// has spread to `50%` of the widget's area.
  final double? eventCallBackableMinPercent;

  /// Merges the current [TouchRippleBehavior] with another, using the provided 
  /// behavior's values if available. If the other behavior is null or lacks 
  /// specific values, defaults to the current behavior's values.
  TouchRippleBehavior merge(TouchRippleBehavior? other) {
    if (other == null) return this;

    return TouchRippleBehavior(
      spreadDuration: other.spreadDuration ?? spreadDuration,
      spreadCurve: other.spreadCurve ?? spreadCurve,
      fadeInDuration: other.fadeInDuration ?? fadeInDuration,
      fadeInCurve: other.fadeInCurve ?? fadeInCurve,
      fadeOutDuration: other.fadeOutDuration ?? fadeOutDuration,
      fadeOutCurve: other.fadeOutCurve ?? fadeOutCurve,
      cancelDuration: other.cancelDuration ?? cancelDuration,
      cancelCurve: other.cancelCurve ?? cancelCurve,
      lowerPercent: other.lowerPercent ?? lowerPercent,
      upperPercent: other.upperPercent ?? upperPercent,
      fadeLowerPercent: other.fadeLowerPercent ?? fadeLowerPercent,
      fadeUpperPercent: other.fadeUpperPercent ?? fadeUpperPercent,
      eventCallBackableMinPercent: other.eventCallBackableMinPercent ?? other.eventCallBackableMinPercent
    );
  }
}
