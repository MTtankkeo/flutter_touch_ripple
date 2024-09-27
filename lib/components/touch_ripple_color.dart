import 'package:flutter/painting.dart';

class TouchRippleColor {
  static withAlphaOf(Color parent, double ratio) {
    return parent.withAlpha((parent.alpha * ratio).toInt());
  }
}