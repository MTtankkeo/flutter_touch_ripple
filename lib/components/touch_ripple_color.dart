import 'package:flutter/painting.dart';

class TouchRippleColor {
  static Color withAlphaOf(Color parent, double ratio) {
    return parent.withAlpha((parent.alpha * ratio).toInt());
  }
}