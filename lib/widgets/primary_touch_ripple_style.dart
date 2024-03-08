import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/style.dart';

class PrimaryTouchRippleStyle extends InheritedWidget {
  const PrimaryTouchRippleStyle({
    super.key,
    required super.child,
    required this.style,
  });

  /// This touch-ripple style propagates sub-wards and provides
  /// a default style.
  final TouchRippleStyle style;
  
  @override
  bool updateShouldNotify(PrimaryTouchRippleStyle oldWidget) {
    return oldWidget.style != style;
  }
}