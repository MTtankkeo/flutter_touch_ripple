import 'package:flutter/animation.dart';

/// Signature for the callback function that is called when a touch ripple effect
/// is triggered. The [offset] parameter provides the position of the touch
/// event relative to a widget coordinate system.
typedef TouchRippleCallback = void Function(Offset offset);

/// Signature for the callback function that is called to determine
/// whether a continuable touch ripple event should continue.
/// 
/// The [count] parameter indicates how many times the event has occurred
/// consecutively, and the returned [bool] specifies whether
/// the continuable touch ripple event should continue.
typedef TouchRippleContinuableCallback = bool Function(int count);

/// Signature for the callback function that is called when a consecutive
/// touch ripple event occurs, combining both the behavior of
/// [TouchRippleCallback] and [TouchRippleContinuableCallback].
/// 
/// The [offset] parameter provides the position of the touch event relative to
/// the widget coordinate system, and the [count] parameter indicates how many
/// times the event has occurred consecutively. The returned [bool] specifies
/// whether the event should continue after the consecutive occurrence.
typedef TouchRippleConsecutiveCallback = bool Function(Offset offset, int count);