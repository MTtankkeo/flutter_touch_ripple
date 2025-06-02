import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

/// The enumeration specifies the rendering order of the touch ripple effect,
/// determining whether it should appear in the foreground or background.
enum TouchRippleRenderOrderType {
  /// Sets the behavior to draw the touch ripple in the foreground, meaning
  /// it will appear above all other visual widgets in the interface.
  foreground,

  /// Sets the behavior to draw the touch ripple in the background, ensuring
  /// it appears beneath all other visual widgets in the interface.
  background,
}

class TouchRippleRender extends StatefulWidget {
  const TouchRippleRender({
    super.key,
    required this.child,
    required this.orderType,
    required this.controller,
  });

  final TouchRippleRenderOrderType orderType;
  final TouchRippleController controller;
  final Widget child;

  @override
  State<TouchRippleRender> createState() => _TouchRippleRenderState();
}

class _TouchRippleRenderState extends State<TouchRippleRender> {
  /// Returns an instance of a given [TouchRippleController] as this widget reference.
  TouchRippleController get controller => widget.controller;

  /// Called when the touch ripple state updated.
  void onUpdated() => setState(() {});

  @override
  void initState() {
    super.initState();
    controller.addListener(onUpdated);
  }

  @override
  void activate() {
    super.activate();
    controller.addListener(onUpdated);
  }

  @override
  void deactivate() {
    super.deactivate();
    controller.removeListener(onUpdated);
  }

  @override
  Widget build(BuildContext context) {
    CustomPainter? backgroundPainter;
    CustomPainter? foregroundPainter;

    /// The instance of a current painter for a ripple effect.
    final painter = TouchRipplePainter(controller: widget.controller);

    if (widget.orderType == TouchRippleRenderOrderType.background) {
      backgroundPainter = painter;
    } else {
      foregroundPainter = painter;
    }

    return CustomPaint(
      foregroundPainter: foregroundPainter,
      painter: backgroundPainter,
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
    effect.paint(controller.context, canvas, size);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final borderRadius = controller.context.rippleBorderRadius;
    final clippingType = controller.context.shape;

    // Returns a Rect instance corresponding to the current canvas size
    // and calculates it based on the center.
    Rect sizeRectOf(Size size) {
      Size rippleSize = size;
      rippleSize *= controller.context.rippleScale;
      rippleSize = Size(
        rippleSize.width + controller.context.ripplePadding * 2,
        rippleSize.height + controller.context.ripplePadding * 2
      );

      final offset = (sizeToOffset(size) - sizeToOffset(rippleSize)) / 2;

      return Rect.fromLTWH(offset.dx, offset.dy, rippleSize.width, rippleSize.height);
    }

    if (clippingType == TouchRippleShape.normal) {
      // When the border radius is zero, no RRect operation is required.
      borderRadius == BorderRadius.zero
        ? canvas.clipRect(sizeRectOf(size))
        : canvas.clipRRect(borderRadius.toRRect(sizeRectOf(size)));
    } else {
      late double rippleSize;

      if (clippingType == TouchRippleShape.inner_circle) {
        rippleSize = max(size.width, size.height);
      } else {
        rippleSize = Offset(size.width, size.height).distance;
      }

      // The post processing for the ripple scale and padding.
      rippleSize *= controller.context.rippleScale;
      rippleSize += controller.context.ripplePadding;

      final dx = (size.width - rippleSize) / 2;
      final dy = (size.height - rippleSize) / 2;

      canvas.clipRRect(
        BorderRadius.circular(1e10).toRRect(
          Rect.fromLTWH(dx, dy, rippleSize, rippleSize)
        ),
      );
    }

    for (final effect in controller.activeEffects) {
      paintByState(canvas, size, effect);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
