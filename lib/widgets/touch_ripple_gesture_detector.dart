import 'package:flutter/widgets.dart';

class TouchRippleGestureDetector extends StatefulWidget {
  const TouchRippleGestureDetector({
    super.key,
    required this.child,
  });

  final Widget child;

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