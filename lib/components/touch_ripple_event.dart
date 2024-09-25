import 'package:flutter/animation.dart';

/// Signature for the callback function that is called when a touch ripple effect
/// is triggered. The [offset] parameter provides the position of the touch 
/// event relative to a widget coordinate system.
typedef TouchRippleCallback = void Function(Offset offset);
