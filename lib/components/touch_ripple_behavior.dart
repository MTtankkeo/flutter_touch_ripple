import 'package:flutter/animation.dart';

class TouchRippleBehavior {
  const TouchRippleBehavior({
    this.spreadDuration,
    this.spreadCurve,
  });

  /// The duration of a touch ripple spreading animation.
  final Duration? spreadDuration;

  /// The curve of a touch ripple spreading curved animation.
  final Curve? spreadCurve;
}