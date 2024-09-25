import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_behavior.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_context.dart';

abstract class TouchRippleEffect extends Listenable {
  /// Called when after the touch ripple effect has fully completed
  /// and the relevant instances have been cleaned up.
  VoidCallback? onDispose;

  paint(TouchRippleContext context, Canvas canvas, Size size);
}

class TouchRippleSpreadingEffect extends TouchRippleEffect {
  TouchRippleSpreadingEffect({
    required TickerProvider vsync,
    required VoidCallback callback,
    required this.isRejectable,
    required this.baseOffset,
    required this.behavior,
  }) {
    assert(behavior.spreadDuration != null);
    assert(behavior.spreadCurve != null);
    _spreadAnimation = AnimationController(vsync: vsync, duration: behavior.spreadDuration!);
    _spreadCurved = CurvedAnimation(parent: _spreadAnimation, curve: behavior.spreadCurve!);

    // Calls the event callback function when the current animation
    // progress can call the event callback function.
    void checkEventCallBack() {
      assert(behavior.lowerPercent != null, "Lower percent of touch ripple behavior was not initialized.");
      assert(behavior.upperPercent != null, "Upper percent of touch ripple behavior was not initialized.");
      final lowerPercent = behavior.lowerPercent ?? 0;

      if (isRejectable) return;
      if (spreadPercent >= (behavior.eventCallBackableMinPercent ?? lowerPercent)) {
        callback.call();
        // Deregisters the listener as there is no longer a need to know
        // when to invoke the event callback function.
        _spreadAnimation.removeListener(checkEventCallBack);
      }
    }

    _spreadAnimation.addListener(checkEventCallBack);
    _spreadAnimation.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        _fadeAnimation.forward();
      }

      if (status == AnimationStatus.completed && isRejectable == false) {
        _fadeAnimation.reverse();
      }
    });

    assert(behavior.fadeInDuration != null);
    assert(behavior.fadeInCurve != null);
    _fadeAnimation = AnimationController(vsync: vsync, duration: behavior.fadeInDuration!);
    _fadeCurved = CurvedAnimation(parent: _fadeAnimation, curve: behavior.fadeInCurve!);

    _fadeAnimation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) dispose();
    });
  }

  // The offset that serves as the reference point for a spread ripple effect.
  final Offset baseOffset;

  final TouchRippleBehavior behavior;

  final bool isRejectable;

  late final AnimationController _spreadAnimation;
  late final CurvedAnimation _spreadCurved;

  late final AnimationController _fadeAnimation;
  late final CurvedAnimation _fadeCurved;

  /// Returns animation progress value of spread animation.
  double get spreadPercent {
    final lowerPercent = behavior.lowerPercent ?? 0;
    final upperPercent = behavior.upperPercent ?? 1;

    return lowerPercent + (upperPercent - lowerPercent) * _spreadCurved.value;
  }

  /// Returns animation progress value of fade animation.
  double get fadePercent {
    final lowerPercent = behavior.fadeLowerPercent ?? 0;
    final upperPercent = behavior.fadeUpperPercent ?? 1;

    return lowerPercent + (upperPercent - lowerPercent) * _fadeCurved.value;
  }

  @override
  void addListener(VoidCallback listener) {
    _spreadAnimation.addListener(listener);
    _fadeAnimation.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _spreadAnimation.addListener(listener);
    _fadeAnimation.addListener(listener);
  }

  /// Converts the size to an offset and returns it.
  static Offset sizeToOffset(Size size) {
    return Offset(size.width, size.height);
  }

  start() {
    _spreadAnimation.forward();
  }

  /// Resets the speed of the fade-out animation to the speed corresponding
  /// to the defined action and forces the effect to fade out.
  /// In some cases, it cancels the effect altogether.
  void cancel() {
    _fadeAnimation.duration = behavior.cancelDuration;
    _fadeCurved.curve = behavior.cancelCurve!;
    _fadeAnimation.reverse();
  }

  @override
  paint(TouchRippleContext context, Canvas canvas, Size size) {
    // Returns how far the given offset is from the centre of the canvas size,
    // defined as a percentage (0~1), relative to the canvas size.
    Offset centerToRatioOf(Offset offset) {
      final sizeOffset = sizeToOffset(size);
      final dx = (offset.dx / sizeOffset.dx) - 0.5;
      final dy = (offset.dy / sizeOffset.dy) - 0.5;

      return Offset(dx.abs(), dy.abs());
    }

    // If a touch event occurs at the exact center,
    // it is the size at which the touch ripple effect fills completely.
    final centerDistance = sizeToOffset(size / 2).distance;

    // However, since touch events don't actually occur at the exact center but at various offsets,
    // it is necessary to compensate for this.
    //
    // If the touch event moves away from the center,
    // the touch ripple effect should expand in size accordingly.
    //
    // This defines the additional scale that needs to be expanded.
    final centerToRatio = centerToRatioOf(baseOffset);

    // temp
    final blur = 0.0;
    final color = context.rippleColor;

    // This defines the additional touch ripple size.
    final distance = Offset(
          sizeToOffset(size).dx * centerToRatio.dx,
          sizeToOffset(size).dy * centerToRatio.dy,
        ).distance +
        (blur * 2);

    final paintSize = (centerDistance + distance) * spreadPercent;
    final paintColor = color.withAlpha(((color.alpha) * fadePercent).toInt());
    final paint = Paint()
      ..color = paintColor
      ..style = PaintingStyle.fill;

    if (blur != 0) {
      paint.maskFilter = MaskFilter.blur(BlurStyle.normal, blur);
    }

    canvas.drawCircle(baseOffset, paintSize * context.rippleScale, paint);
  }

  dispose() {
    onDispose?.call();
    _spreadAnimation.dispose();
    _spreadCurved.dispose();
    _fadeAnimation.dispose();
    _fadeCurved.dispose();
  }
}
