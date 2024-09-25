import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_controller.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_effect.dart';

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
  /// Returns an instance of a given [TouchRippleController] as this widget reference.
  TouchRippleController get controller => widget.controller;

  @override
  void initState() {
    super.initState();

    controller.addListener(() => setState(() {}));
  }

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

  /// Converts the size to an offset and returns it.
  static Offset sizeToOffset(Size size) {
    return Offset(size.width, size.height);
  }

  /// Draws a painting corresponding to a given instance of touch ripple effect.
  void paintByState(Canvas canvas, Size size, TouchRippleEffect effect) {
    // Returns a Rect instance corresponding to the current canvas size
    // and calculates it based on the center.
    Rect getSizeRect() {
      final scaledSize = size * controller.context.rippleScale;
      final offset = (sizeToOffset(size) - sizeToOffset(scaledSize)) / 2;

      return Rect.fromLTWH(offset.dx, offset.dy, scaledSize.width, scaledSize.height);
    }

    canvas.clipRRect(controller.context.rippleBorderRadius.toRRect(getSizeRect()));
    effect.paint(controller.context, canvas, size);
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final effect in controller.activeEffects) {
      paintByState(canvas, size, effect);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
