import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_controller.dart';

class TouchRippleRender extends StatefulWidget {
  const TouchRippleRender({
    super.key,
    required this.child,
    required this.controller,
  });

  final Widget child;
  final TouchRippleController controller;

  @override
  State<TouchRippleRender> createState() => _TouchRippleRenderState();
}

class _TouchRippleRenderState extends State<TouchRippleRender> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TouchRipplePainter(controller: widget.controller),
      child: widget.child,
    );
  }
}

class TouchRipplePainter extends CustomPainter {
  const TouchRipplePainter({
    required this.controller,
  });

  final TouchRippleController controller;

  @override
  void paint(Canvas canvas, Size size) {
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}