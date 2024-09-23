import 'package:flutter/cupertino.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_controller.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple_connection.dart';

/// This widget, inspired by Google Material's ripple effect,
/// visualizes various gestures such as tap, double tap,
/// and long press through ripple effects.
///
class TouchRipple extends TouchRippleConnection {
  const TouchRipple({
    super.key,
    super.onTap,
    super.onDoubleTap,
    super.onLongTap,
    super.behavior,
    required super.child,
    this.controller,
  });

  final TouchRippleController? controller;

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
      behavior: widget.behavior,
      child: widget.child,
    );
  }
}