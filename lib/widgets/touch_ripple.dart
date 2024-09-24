import 'package:flutter/cupertino.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_controller.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple_connection.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple_render.dart';

/// This widget, inspired by Google Material's ripple effect,
/// visualizes various gestures such as tap, double tap,
/// and long press through ripple effects.
///
class TouchRipple extends StatefulWidget {
  const TouchRipple({
    super.key,
    this.onTap,
    this.onDoubleTap,
    this.onLongTap,
    this.behavior,
    this.controller,
    required this.child,
  });

  /// This callback function is called when the user taps or clicks.
  final Function? onTap;

  /// This callback function is called when the user double taps or double clicks.
  final Function? onDoubleTap;

  /// This callback function is called when the user long presses or long clicks.
  final Function? onLongTap;

  /// This defines the behavior of hit testing for the child widget.
  final HitTestBehavior? behavior;

  final TouchRippleController? controller;

  final Widget child;

  @override
  State<TouchRipple> createState() => _TouchRippleState();
}

class _TouchRippleState extends State<TouchRipple> {
  late TouchRippleController _controller = widget.controller ?? TouchRippleController();

  @override
  void didUpdateWidget(covariant TouchRipple oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != null
     && oldWidget.controller != widget.controller) {
      _controller = widget.controller!..delegateFrom(_controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TouchRippleConnection(
      onTap: widget.onTap,
      onDoubleTap: widget.onDoubleTap,
      onLongTap: widget.onLongTap,
      behavior: widget.behavior ?? HitTestBehavior.translucent,
      controller: _controller,
      child: TouchRippleRender(controller: _controller, child: widget.child),
    );
  }
}