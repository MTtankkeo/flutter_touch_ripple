import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/controller.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';





class PrimaryTouchRippleController extends InheritedWidget {
  const PrimaryTouchRippleController({
    super.key,
    required this.controller,
    required super.child,
  });

  /// The [TouchRippleController] associated with the subtree.
  /// 
  /// See also:
  ///  * [TouchRipple.controller], which discusses the purpose of specifying a
  ///    scroll controller.
  final TouchRippleController? controller;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}