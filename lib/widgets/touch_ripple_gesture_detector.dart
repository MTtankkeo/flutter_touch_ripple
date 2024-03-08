import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/controller.dart';

class TouchRippleGestureDetector extends StatefulWidget {
  const TouchRippleGestureDetector({
    super.key,
    required this.child,
    required this.controller,
  });

  /// The widget that is below this widget in the tree and
  /// detects gestures.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// The controller is for touch effects control,
  /// must be provided unconditionally to manage touch effects.
  final TouchRippleController controller;

  @override
  State<TouchRippleGestureDetector> createState() => _TouchRippleGestureDetectorState();
}

class _TouchRippleGestureDetectorState extends State<TouchRippleGestureDetector> {
  void _handlePointerDown(PointerDownEvent event) {
    // event.pointer;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _handlePointerDown,
      child: widget.child,
    );
  }
}