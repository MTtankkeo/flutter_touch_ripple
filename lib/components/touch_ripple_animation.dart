import 'package:flutter/animation.dart';

/// This data class defines animation settings (e.g., fade-in, fade-out)  
/// for the touch ripple effect that is including duration and curve.
class TouchRippleAnimation {
  const TouchRippleAnimation({
    this.fadeInDuration,
    this.fadeInCurve,
    this.fadeOutDuration,
    this.fadeOutCurve
  });

  final Duration? fadeInDuration;
  final Curve? fadeInCurve;
  final Duration? fadeOutDuration;
  final Curve? fadeOutCurve;

  /// Merges the current [TouchRippleAnimation] with another, using the provided 
  /// animation values if available. If the other behavior is null or lacks 
  /// specific values, defaults to the current animation values.
  TouchRippleAnimation merge(TouchRippleAnimation? other) {
    if (other == null) return this;

    return TouchRippleAnimation(
      fadeInDuration: other.fadeInDuration ?? fadeInDuration,
      fadeInCurve: other.fadeInCurve ?? fadeInCurve,
      fadeOutDuration: other.fadeOutDuration ?? fadeOutDuration,
      fadeOutCurve: other.fadeOutCurve ?? fadeOutCurve
    );
  }
}