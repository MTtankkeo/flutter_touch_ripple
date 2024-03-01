import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/states.dart';

/// Draws effects corresponding to the given [TouchRipplePaintable].
class TouchRipplePainter<T extends TouchRipplePaintable> extends CustomPainter {
  const TouchRipplePainter({
    required this.states,
    required this.color,
    required this.scale,
    required this.blur,
    required this.borderRadius,
  });

  final List<T> states;
  final Color color;
  final double scale;
  final double blur;
  final BorderRadius borderRadius;

  /// Converts the size to an offset and returns it.
  static Offset sizeToOffset(Size size) {
    return Offset(size.width, size.height);
  }

  /// Draws a painting corresponding to the given touch ripple state.
  void paintByState(Canvas canvas, Size size, T state) {
    // Returns a Rect instance corresponding to the current canvas size
    // and calculates it based on the center.
    Rect getSizeRect() {
      final scaledSize = size * scale;
      final offset = (sizeToOffset(size) - sizeToOffset(scaledSize)) / 2;
      return Rect.fromLTWH(
        offset.dx,
        offset.dy,
        scaledSize.width,
        scaledSize.height
      );
    }

    canvas.clipRRect(borderRadius.toRRect(getSizeRect()));
    state.paint(
      canvas: canvas,
      size: size,
      scale: scale,
      blur: blur,
      color: color
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Call the paintByState function for all states to draw the touch ripple effect.
    for (final state in states) {
      paintByState(canvas, size, state);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
