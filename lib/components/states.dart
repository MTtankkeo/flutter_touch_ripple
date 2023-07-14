// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/behavior.dart';





/// Provides an interface for animating the touch ripple effect.
mixin AnimationableTouchRippleMixin {
  /// Run the animation initialised in the current instance.
  void start();

  /// Stop the actived animation of current instance.
  void stop();

  /// Run the fade-in animation.
  void fadeIn();

  /// Run the fade-out animation.
  void fadeOut();

  /// Disposes of the initialized animation instances.
  void dispose();
}

/// Declaring the functionalities that are the basis for drawing the touch ripple effect.
abstract class TouchRipplePaintable extends Listenable {
  const TouchRipplePaintable();

  /// Perform to take a paint task corresponding to the current state,
  /// referencing the given arguments.
  void paint({
    required Canvas canvas,
    required Size size,
    required double scale,
    required Color color,
  });
}

/// Initialize, manage, and connect multiple animation objects to implement the touch ripple effect.
/// 
/// How to initialized:
/// ```dart
/// /// Since multiple tickers need to be created and managed,
/// /// [SingleTickerProviderStateMixin] should not be used.
/// class WidgetState extends State<Widget> with TickerProviderStateMixin {
/// 
///   /// Create a new [TouchRippleState] instance.
///   final state =TouchRippleState(
///     vsync: this,
///     behavior: TouchRippleBehavior(), // Initialize all arguments
///     callback: onTap,
///     onDismissed: (state) => controller.dispatch(state),
///     eventedOffset: Offset.zero,
///   );
/// }
/// ```
class TouchRippleState extends TouchRipplePaintable with AnimationableTouchRippleMixin {
  /// The pointer offset that is the reference point for where the effect spreads.
  /// 
  /// See also:
  /// - The gesture detector detects the gesture and then refers to
  ///    the current pointer offset after the gesture is accepted.
  final Offset eventedOffset;
  
  /// Whether the instance was created while the gesture was not accepted.
  /// 
  /// See also:
  /// - This implies an unstable state where the gesture that creates
  ///    that instance can be rejected in the middle.
  late bool _isRejectable;

  /// The animation controller for the touch ripple effect spread animation.
  late final AnimationController _spreadAnimation;

  /// The curved animation for the touch ripple effect spread animation.
  late final CurvedAnimation _spreadCurved;

  /// The animation controller for the fade in or fade out animation of touch ripple effect.
  late final AnimationController _fadeAnimation;

  /// The curved animation for the fade in or fade out animation of touch ripple effect.
  late final CurvedAnimation _fadeCurved;

  /// The touch ripple behavior given at initialization.
  /// 
  /// See also:
  /// - The animation instances corresponding to that behavior is initialized.
  late final TouchRippleBehavior _behavior;

  /// Returns animation progress value of spread animation.
  double get spreadPercent {
    final lowerPercent = _behavior.lowerPercent ?? 0;
    final upperPercent = _behavior.upperPercent ?? 1;

    return lowerPercent +
          (upperPercent - lowerPercent) * _spreadCurved.value;
  }

  /// Returns animation progress value of fade animation.
  double get fadePercent {
    final lowerPercent = _behavior.fadeLowerPercent ?? 0;
    final upperPercent = _behavior.fadeUpperPercent ?? 1;

    return lowerPercent +
          (upperPercent - lowerPercent) * _fadeCurved.value;
  }

  /// Initializes several animation instance needed to implement the touch ripple effect.
  /// 
  /// Initializes the spread animation and defines the fade behavior based
  /// on the state of the spread animation,
  /// 
  /// If the spread animation value has updated, it will continue to check the animation value
  /// until it can call the event callback function,
  /// 
  /// When create a [TouchRippleState] instance while the gesture is not accepted,
  /// the event callback function call postponed until the gesture is accepted.
  /// 
  /// - When we say that a gesture is not accepted,
  ///    we are primarily referring to situations where the gesture may be rejected midway through,
  ///    or where we create a touch ripple state instance with the gesture not accepted
  ///    in order to show the user the effect in advance.
  /// 
  /// Initializes the fade animation and defines the behavior based on the state of the fade animation.
  /// For example, if the fade-out state is complete,
  /// call the given [onDismissed] so that this instance can be dispatched from the controller.
  /// 
  /// Arguments:
  /// - The given [callback] is invoked at the the event
  ///    callback timing corresponding to the given [behavior].
  /// 
  /// - The given [isRejectable] defines whether the instance was initialized
  ///    while the gesture was not yet accepted.
  /// 
  /// See also:
  /// - Call a given callback function based on the state of the animation.
  TouchRippleState({
    required TickerProvider vsync,
    required TouchRippleBehavior behavior,
    required VoidCallback callback,
    required void Function(TouchRippleState state) onDismissed,
    required this.eventedOffset,
    bool isRejectable = false,
  }) : _isRejectable = isRejectable,
       _behavior = behavior
  {
    assert(behavior.spreadDuration != null, 'Spread duration of touch ripple behavior was not initialized.');
    _spreadAnimation = AnimationController(
      vsync: vsync,
      duration: behavior.spreadDuration ?? Duration.zero,
    );

    // Call the event callback function when the current animation
    // progress can call the event callback function.
    void checkEventCallBack() {
      assert(behavior.lowerPercent != null, 'Lower percent of touch ripple behavior was not initialized.');
      final lowerPercent = behavior.lowerPercent ?? 0;
      
      if (_isRejectable) return;
      if (spreadPercent >= (behavior.eventCallBackableMinPercent ?? lowerPercent)) {
        callback.call();
        // Deregistering the listener as there is no longer a need to know
        // when to invoke the event callback function.
        _spreadAnimation.removeListener(checkEventCallBack);
      }
    }
    _spreadAnimation.addListener(checkEventCallBack);
    _spreadAnimation.addStatusListener((status) {
      if (status == AnimationStatus.forward) fadeIn();
      if (status == AnimationStatus.completed && _isRejectable == false) fadeOut();
    });

    assert(behavior.spreadCurve != null, 'Spread curve of touch ripple behavior was not initialized.');
    _spreadCurved = CurvedAnimation(
      parent: _spreadAnimation,
      curve: behavior.spreadCurve ?? Curves.linear,
    );

    _fadeAnimation = AnimationController(
      vsync: vsync,
      duration: behavior.fadeInDuration,
      reverseDuration: behavior.fadeOutDuration,
    );
    _fadeAnimation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) onDismissed.call(this);
    });

    assert(behavior.fadeInCurve != null, 'Fade in curve of touch ripple behavior was not initialized.');
    assert(behavior.fadeOutCurve != null, 'Fade out curve of touch ripple behavior was not initialized.');
    _fadeCurved = CurvedAnimation(
      parent: _fadeAnimation,
      curve: behavior.fadeInCurve ?? Curves.linear,
      reverseCurve: behavior.fadeOutCurve,
    );
  }
  
  @override
  void start() => _spreadAnimation.forward();

  @override
  void fadeIn() => _fadeAnimation.forward();

  @override
  void fadeOut() => _fadeAnimation.reverse();

  @override
  void stop() {
    _spreadAnimation.stop();
    _fadeAnimation.stop();
  }

  /// Resets the speed of the fade-out animation to the speed corresponding
  /// to the defined action and forces the effect to fade out.
  /// In some cases,
  /// it cancels the effect altogether.
  void cancel({
    required TouchRippleCancelBehavior cancelBehavior,
  }) {
    _fadeAnimation.duration = _behavior.canceledDuration ?? Duration.zero;
    _fadeCurved.curve = _behavior.canceledCurve ?? _behavior.fadeOutCurve!;

    fadeOut();
    switch (cancelBehavior) {
      case TouchRippleCancelBehavior.reverseSpread: _spreadAnimation.reverse(); break;
      case TouchRippleCancelBehavior.stopSpread: _spreadAnimation.stop(); break;
      case TouchRippleCancelBehavior.none: break;
      default: throw Exception('An undeclared behavior instnace was defined.');
    }
  }
  
  /// Resets the current animation setting values of this instance
  /// with a value that corresponds to the given touch ripple behaviour.
  void resetWith({
    required TouchRippleBehavior behavior,
  }) {
    _behavior = behavior;
    _spreadAnimation.duration = _behavior.spreadDuration;
    _fadeAnimation.duration = _behavior.fadeInDuration;
    _fadeAnimation.reverseDuration = _behavior.fadeOutDuration;

    assert(behavior.fadeInCurve != null, 'Fade in curve of touch ripple behavior was not initialized.');
    assert(behavior.fadeOutCurve != null, 'Fade out curve of touch ripple behavior was not initialized.');
    _fadeCurved.curve = _behavior.fadeInCurve ?? Curves.linear;
    _fadeCurved.reverseCurve = _behavior.fadeOutCurve;
  }

  /// If the gesture could be rejected and is eventually accepted,
  /// please call the corresponding function.
  void onAccepted() {
    assert(_isRejectable, 'The gesture has already been defined as accepted.');
    _isRejectable = false;
    _spreadAnimation.notifyListeners();
    _spreadAnimation.notifyStatusListeners(_spreadAnimation.status);
  }

  void onRejected() => fadeOut();

  /// Redefines the vsync of the current animation instance with the given Ticker Provider.
  void resync(TickerProvider vsync) {
    _spreadAnimation.resync(vsync);
    _fadeAnimation.resync(vsync);
  }
  
  @override
  void addListener(VoidCallback listener) {
    _spreadAnimation.addListener(listener);
    _fadeAnimation.addListener(listener);
  }
  
  @override
  void removeListener(VoidCallback listener) {
    _spreadAnimation.removeListener(listener);
    _fadeAnimation.removeListener(listener);
  }

  void addFadeStatusListener(AnimationStatusListener listener) {
    _fadeAnimation.addStatusListener(listener);
  }

  void removeFadeStatusListener(AnimationStatusListener listener) {
    _fadeAnimation.removeStatusListener(listener);
  }

  @override
  void dispose() {
    _spreadAnimation.dispose();
    _fadeAnimation.dispose();
  }

  /*
   * Touch Ripple Paintable
  */

  /// Converts the size to an offset and returns it.
  static Offset sizeToOffset(Size size) {
    return Offset(size.width, size.height);
  }

  @override
  void paint({
    required Canvas canvas,
    required Size size,
    required double scale,
    required Color color,
  }) {
    // Returns how far the given offset is from the centre of the canvas size,
    // defined as a percentage (0~1), relative to the canvas size.
    Offset centerToRatioOf(Offset offset) {
      final sizeOffset = sizeToOffset(size);
      final dx = (offset.dx / sizeOffset.dx) - 0.5;
      final dy = (offset.dy / sizeOffset.dy) - 0.5;
      
      return Offset(dx.abs(), dy.abs());
    }

    /// The offset that serves as the reference point for the spread of the effect.
    final baseOffset = eventedOffset;

    /// If a touch event occurs at the exact center,
    /// it is the size at which the touch ripple effect fills completely.
    final centerDistance = sizeToOffset(size / 2).distance;

    /// However, since touch events don't actually occur at the exact center but at various offsets,
    /// it is necessary to compensate for this.
    /// 
    /// If the touch event moves away from the center,
    /// the touch ripple effect should expand in size accordingly.
    /// 
    /// This defines the additional scale that needs to be expanded.
    final centerToRatio = centerToRatioOf(baseOffset);

    /// This defines the additional touch ripple size.
    final distance = Offset(
      sizeToOffset(size).dx * centerToRatio.dx,
      sizeToOffset(size).dy * centerToRatio.dy
    ).distance;

    final paintSize = (centerDistance + distance) * spreadPercent;
    final paintColor = color.withAlpha(((color.alpha) * fadePercent).toInt());
    final paint = Paint()
      ..color = paintColor
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(baseOffset, paintSize * scale, paint);
  }
}

class TouchRippleBackgroundState extends TouchRipplePaintable with AnimationableTouchRippleMixin {

  late final Color color;
  
  /// The animation controller for the fade in or fade out animation of touch ripple hover effect.
  late final AnimationController _fadeAnimation;

  /// The curved animation for the fade in or fade out animation of touch ripple hover effect.
  late final CurvedAnimation _fadeCurved;

  /// Returns animation progress value of fade animation.
  double get fadePercent => _fadeCurved.value;
  
  TouchRippleBackgroundState({
    required TickerProvider vsync,
    required this.color,
    required Duration fadeInDuration,
    required Curve fadeInCurve,
    required Duration? fadeOutDuration,
    required Curve? fadeOutCurve,
    required VoidCallback onDismissed,
  }) {
    _fadeAnimation = AnimationController(
      vsync: vsync,
      duration: fadeInDuration,
      reverseDuration: fadeOutDuration,
    );
    _fadeAnimation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) onDismissed.call();
    });

    _fadeCurved = CurvedAnimation(
      parent: _fadeAnimation,
      curve: fadeInCurve,
      reverseCurve: fadeOutCurve,
    );
  }

  @override
  void paint({
    required Canvas canvas,
    required Size size,
    required double scale,
    required Color color,
  }) {
    final paintColor = this.color.withAlpha(((this.color.alpha) * fadePercent).toInt());
    final paint = Paint()
      ..color = paintColor
      ..style = PaintingStyle.fill;
    
    canvas.drawPaint(paint);
  }

  @override
  void start() => fadeIn();

  @override
  void stop() => _fadeAnimation.stop();

  @override
  void fadeIn() => _fadeAnimation.forward();

  @override
  void fadeOut() => _fadeAnimation.reverse();
  
  @override
  void addListener(VoidCallback listener) => _fadeAnimation.addListener(listener);
  
  @override
  void removeListener(VoidCallback listener) => _fadeAnimation.removeListener(listener);
  
  @override
  void dispose() {
    _fadeAnimation.dispose();
    _fadeCurved.dispose();
  }
}