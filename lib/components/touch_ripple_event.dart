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

/// Signature for the callback function that is called to indicate 
/// the occurrence of consecutive touch ripple events.
/// 
/// Unlike [TouchRippleContinuableCallback], this callback does not 
/// determine whether the event should continue; instead, it serves 
/// to inform that a series of consecutive events has occurred.
typedef TouchRippleConsecutiveCallback = void Function(int count);