import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

/// This data class defines multiple touch-ripple behaviors.
/// 
/// Used by [TouchRipple] and [TouchRippleGestureDetector].
class TouchRippleStyle {
  const TouchRippleStyle({
    this.behvaior,
    this.tapBehvaior,
  });

  final TouchRippleBehvaior? behvaior;
  final TouchRippleBehvaior? tapBehvaior;
}