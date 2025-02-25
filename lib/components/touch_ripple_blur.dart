import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_effect.dart';

/// This class provides getter for the blur radius.
abstract class TouchRippleBlur {
  const TouchRippleBlur();

  /// Returns the blur radius of the touch ripple effect by a given instance and size.
  double calculateRadius(TouchRippleEffect effect, Size size);
}

class MaterialTouchRippleBlur extends TouchRippleBlur {
  const MaterialTouchRippleBlur.fixed(this.value)
    : isPercent = false,
      minValue = -double.infinity,
      maxValue = double.infinity;

  const MaterialTouchRippleBlur.percent(this.value, {
    this.minValue = -double.infinity,
    this.maxValue = double.infinity
  }) : isPercent = true;

  final double value;
  final double minValue;
  final double maxValue;

  final bool isPercent;

  @override
  double calculateRadius(TouchRippleEffect effect, Size size) {
    if (isPercent) {
      assert(value >= 0, "A percent blur radius must be defined from 0 to 1.");
      assert(value <= 1, "A percent blur radius must be defined from 0 to 1.");
      final double radius = max(size.width, size.height) * value;

      // Clips the calculated radius result by a given min from max.
      return radius.clamp(minValue, maxValue);
    }

    assert(value >= 0, "A blur radius must be defined from 0 to 1.");
    return value;
  }
}