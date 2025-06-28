import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

@protected
extension ColorExtensions on Color {
  Color fade(double percent) {
    final int alpha = (a * 255).round();
    return withAlpha((alpha * percent).toInt());
  }
}
