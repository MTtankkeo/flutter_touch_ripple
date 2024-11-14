// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_animation.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_behavior.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_context.dart';

abstract class TouchRippleEffect extends Listenable {
  /// Called when after the touch ripple effect has fully completed
  /// and the relevant instances have been cleaned up.
  VoidCallback? onDispose;

  /// Whether the ripple effect is attached to the touch ripple controller.
  bool isAttached = false;

  /// Whether all animation-related instances have been initialized.
  bool isInitialized = false;

  /// Disposes of the Ticker or related animation instances.
  ///
  /// Calling this function resolves errors and memory leaks that may occur
  /// when the widget has been disposed but the effect-related instances remain.
  void dispose() {
    assert(onDispose != null, "Should be notifying disposed to the touch ripple controller.");
    onDispose?.call();
  }

  void paint(TouchRippleContext context, Canvas canvas, Size size);
}

class TouchRippleSpreadingEffect extends TouchRippleEffect {
  TouchRippleSpreadingEffect({
    required this.context,
    required this.callback,
    required this.isRejectable,
    required this.baseOffset,
    required this.behavior,
  }) {
    assert(behavior.spreadDuration != null);
    assert(behavior.spreadCurve != null);
    _spreadAnimation = AnimationController(vsync: context.vsync, duration: behavior.spreadDuration!);
    _spreadCurved = CurvedAnimation(parent: _spreadAnimation, curve: behavior.spreadCurve!);

    // Calls the event callback function when the current animation
    // progress can call the event callback function.
    void checkEventCallBack() {
      assert(behavior.lowerPercent != null, "Lower percent of touch ripple behavior was not initialized.");
      assert(behavior.upperPercent != null, "Upper percent of touch ripple behavior was not initialized.");
      final lowerPercent = behavior.lowerPercent ?? 0;

      if (this.isRejectable) return;
      if (this.isAttached && spreadPercent >= (behavior.eventCallBackableMinPercent ?? lowerPercent)) {
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
    _fadeAnimation = AnimationController(
      vsync: context.vsync,
      duration: behavior.fadeInDuration!,
      reverseDuration: behavior.fadeOutDuration!
    );
    _fadeCurved = CurvedAnimation(
      parent: _fadeAnimation,
      curve: behavior.fadeInCurve!,
      reverseCurve: behavior.fadeOutCurve!
    );

    _fadeAnimation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) dispose();
    });

    isInitialized = true;
  }

  // The offset that serves as the reference point for a spread ripple effect.
  final Offset baseOffset;
  final VoidCallback callback;
  final TouchRippleContext context;
  final TouchRippleBehavior behavior;

  bool isRejectable;

  late final AnimationController _spreadAnimation;
  late final CurvedAnimation _spreadCurved;
  late final AnimationController _fadeAnimation;
  late final CurvedAnimation _fadeCurved;

  /// Returns animation progress value of spread animation.
  double get spreadPercent {
    if (isInitialized) return 0;
    final lowerPercent = behavior.lowerPercent ?? 0;
    final upperPercent = behavior.upperPercent ?? 1;

    return lowerPercent + (upperPercent - lowerPercent) * _spreadCurved.value;
  }

  /// Returns animation progress value of fade animation.
  double get fadePercent {
    if (isInitialized) return 0;
    final lowerPercent = behavior.fadeLowerPercent ?? 0;
    final upperPercent = behavior.fadeUpperPercent ?? 1;

    return lowerPercent + (upperPercent - lowerPercent) * _fadeCurved.value;
  }

  @override
  void addListener(VoidCallback listener) {
    assert(isInitialized, "The animation instances has not yet been initialized.");
    _spreadAnimation.addListener(listener);
    _fadeAnimation.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    assert(isInitialized, "The animation instances has not yet been initialized.");
    _spreadAnimation.addListener(listener);
    _fadeAnimation.addListener(listener);
  }

  /// Converts the size to an offset and returns it.
  static Offset sizeToOffset(Size size) {
    return Offset(size.width, size.height);
  }

  start() {
    // Cannot perform the animation task without all animation-related instances being initialized.
    if (!isInitialized) return;
    _spreadAnimation.forward();
  }

  /// Resets the speed of the fade-out animation to the speed corresponding
  /// to the defined action and forces the effect to fade out.
  /// In some cases, it cancels the effect altogether.
  void cancel() {
    // Cannot perform the animation task without all animation-related instances being initialized.
    if (!isInitialized) return;

    _fadeAnimation.reverseDuration = behavior.cancelDuration;
    _fadeCurved.reverseCurve = behavior.cancelCurve;
    _fadeAnimation.reverse();

    switch (context.cancelBehavior) {
      case TouchRippleCancelBehavior.none: break;
      case TouchRippleCancelBehavior.stop: _spreadAnimation.stop(); break;
      case TouchRippleCancelBehavior.reverse: _spreadAnimation.reverse(); break;
      default: assert(true, "No corresponding task for declared enumeration value.");
    }
  }

  /// If the gesture could be rejected and is eventually accepted,
  /// please call the corresponding function.
  void onAccepted() {
    assert(isInitialized, "The animation instances has not yet been initialized.");
    assert(isRejectable, "The gesture has already been defined as accepted.");
    isRejectable = false;
    _spreadAnimation.notifyListeners();
    _spreadAnimation.notifyStatusListeners(_spreadAnimation.status);
  }

  void onRejected() => cancel();

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

    // The background color of a spread ripple effect.
    final color = context.rippleColor;

    // Return the radius pixels of a blur filter to touch ripple.
    final blurRadius = context.rippleBlurRadius;

    // This defines the additional touch ripple size.
    final distance = Offset(
      sizeToOffset(size).dx * centerToRatio.dx,
      sizeToOffset(size).dy * centerToRatio.dy,
    ).distance + (blurRadius * 2);

    final paintSize = (centerDistance + distance) * spreadPercent;
    final paintColor = color.withAlpha(((color.alpha) * fadePercent).toInt());
    final paint = Paint()
      ..color = paintColor
      ..style = PaintingStyle.fill;

    if (blurRadius != 0) {
      paint.maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius);
    }

    canvas.drawCircle(baseOffset, paintSize * context.rippleScale, paint);
  }

  @override
  void dispose() {
    onDispose?.call();

    if (isInitialized) {
      _spreadAnimation.dispose();
      _spreadCurved.dispose();
      _fadeAnimation.dispose();
      _fadeCurved.dispose();
    }
  }
}

class TouchRippleSolidEffect extends TouchRippleEffect {
  TouchRippleSolidEffect({
    required TickerProvider vsync,
    required TouchRippleAnimation animation,
    required this.color,
  }) {
    _fadeAnimation = AnimationController(
      vsync: vsync,
      duration: animation.fadeInDuration,
      reverseDuration: animation.fadeOutDuration,
    );

    _fadeCurved = CurvedAnimation(
      parent: _fadeAnimation,
      curve: animation.fadeInCurve!,
      reverseCurve: animation.fadeOutCurve
    );

    _fadeCurved.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) onDispose?.call();
    });

    isInitialized = true;
  }

  /// The animation controller for the fade in or fade-out animation of
  /// the touch ripple solid effect for hover and consecutive or others.
  late final AnimationController _fadeAnimation;

  /// The curved animation controller for the fade in or fade-out animation
  /// of the touch ripple solid effect for hover and consecutive or others.
  late final CurvedAnimation _fadeCurved;

  /// The background color of this solid effect.
  final Color color;

  /// Returns animation progress value of fade animation.
  double get fadePercent => isInitialized ? _fadeCurved.value : 0;

  @override
  void addListener(VoidCallback listener) {
    assert(isInitialized, "The animation instances has not yet been initialized.");
    _fadeAnimation.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    assert(isInitialized, "The animation instances has not yet been initialized.");
    _fadeAnimation.removeListener(listener);
  }

  @override
  void dispose() {
    if (isInitialized) {
      _fadeAnimation.dispose();
      _fadeCurved.dispose();
    }
  }

  fadeIn() {
    if (isInitialized) _fadeAnimation.forward();
  }

  fadeOut() {
    if (isInitialized) _fadeAnimation.reverse();
  }

  @override
  void paint(TouchRippleContext context, Canvas canvas, Size size) {
    final paintColor = color.withAlpha(((color.alpha) * fadePercent).toInt());
    final paint = Paint()
      ..color = paintColor
      ..style = PaintingStyle.fill;

    canvas.drawPaint(paint);
  }
}
