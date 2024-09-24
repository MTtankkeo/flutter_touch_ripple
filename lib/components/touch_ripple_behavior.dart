import 'package:flutter/animation.dart';

class TouchRippleBehavior {
  const TouchRippleBehavior({
    this.spreadDuration,
    this.spreadCurve,
    this.lowerPercent,
    this.upperPercent,
  }) : assert(lowerPercent != null ? lowerPercent >= 0 && lowerPercent <= 1 : true),
       assert(upperPercent != null ? upperPercent >= 0 && upperPercent <= 1 : true);

  /// The duration of a touch ripple spreading animation.
  final Duration? spreadDuration;

  /// The curve of a touch ripple spreading curved animation.
  final Curve? spreadCurve;

  /// The percentage value of the minimum spread ratio for a touch ripple effect.
  final double? lowerPercent;

  /// The percentage value of the maximum spread ratio for a touch ripple effect.
  final double? upperPercent;
}