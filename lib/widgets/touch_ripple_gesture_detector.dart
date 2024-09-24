import "package:flutter/material.dart";
import "package:flutter_touch_ripple/components/touch_ripple_controller.dart";

/// This widget detects user gestures, notifies the relevant controller that
/// manages touch ripple effects, and delegates the handling to it.
class TouchRippleGestureDetector extends StatefulWidget {
  const TouchRippleGestureDetector({
    super.key,
    this.onTap,
    this.onDoubleTap,
    this.onLongTap,
    this.behavior = HitTestBehavior.translucent,
    required this.controller,
    required this.child,
  });

  /// This callback function is called when the user taps or clicks.
  final Function? onTap;

  /// This callback function is called when the user double taps or double clicks.
  final Function? onDoubleTap;

  /// This callback function is called when the user long presses or long clicks.
  final Function? onLongTap;

  /// This defines the behavior of hit testing for the child widget.
  final HitTestBehavior behavior;

  final TouchRippleController controller;

  /// This widget is the target for detecting gestures related to touch ripple effects.
  final Widget child;

  @override
  State<TouchRippleGestureDetector> createState() => _TouchRippleGestureDetectorState();
}

class _TouchRippleGestureDetectorState extends State<TouchRippleGestureDetector> {

  initPointer(PointerDownEvent event) {
    // GestureBinding.instance.gestureArena.add(event.pointer, );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: widget.behavior,
      onPointerDown: initPointer,
      child: widget.child,
    );
  }
}