import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_touch_ripple/flutter_touch_ripple.dart";

/// Signature for the builder function that creates an instance of [GestureRecognizer].
typedef GestureRecognizerBuilder<T extends GestureRecognizer> = T Function();

/// This widget detects user gestures, notifies the relevant controller that
/// manages touch ripple effects, and delegates the handling to it.
class TouchRippleGestureDetector extends StatefulWidget {
  const TouchRippleGestureDetector({
    super.key,
    this.onTap,
    this.onDoubleTap,
    this.onDoubleTapStart,
    this.onDoubleTapEnd,
    this.onLongTap,
    this.onLongTapStart,
    this.onLongTapEnd,
    this.onConsecutive,
    this.onConsecutiveStart,
    this.onConsecutiveEnd,
    this.onlyMainButton,
    this.behavior = HitTestBehavior.translucent,
    required this.controller,
    required this.child,
  });

  /// The callback function is called when the user taps or clicks.
  final VoidCallback? onTap;

  /// The callback function is called when the user double taps or double clicks.
  final TouchRippleContinuableCallback? onDoubleTap;

  /// The callback function is a lifecycle callback for the double-tap event. 
  /// It is called when a double tap starts, which is useful for handling 
  /// actions that occur during successive double taps.
  final VoidCallback? onDoubleTapStart;

  /// The callback function is a lifecycle callback for the double-tap event. 
  /// It is called when a double tap ends, providing the advantage of knowing 
  /// when a series of consecutive double taps has finished.
  final VoidCallback? onDoubleTapEnd;

  /// The callback function is called when the user long presses or long clicks.
  final TouchRippleContinuableCallback? onLongTap;

  /// The callback function is a lifecycle callback for the long-tap event. 
  /// It is called when a long tap starts, which is useful for initiating 
  /// actions that require a sustained press.
  final VoidCallback? onLongTapStart;

  /// The callback function is a lifecycle callback for the long-tap event. 
  /// It is called when a long tap ends, providing the advantage of knowing 
  /// when a series of consecutive long taps has concluded.
  final VoidCallback? onLongTapEnd;

  /// The callback function is called to indicate the occurrence of consecutive
  /// touch ripple events. See Also, this function does not determine 
  /// whether the event should continue rather, it serves to inform 
  /// that a series of consecutive events has taken place.
  final TouchRippleConsecutiveCallback? onConsecutive;

  /// The callback function is a lifecycle callback for consecutive touch 
  /// ripple events. It is called when a consecutive touch event starts, 
  /// allowing for the initiation of actions based on the beginning of 
  /// the consecutive event sequence.
  final VoidCallback? onConsecutiveStart;

  /// The callback function is a lifecycle callback for consecutive touch 
  /// ripple events. It is called when a consecutive touch event ends, 
  /// providing the advantage of knowing when a series of consecutive 
  /// touch ripple events has concluded.
  final VoidCallback? onConsecutiveEnd;

  /// The boolean that is whether only the main button is recognized as a gesture
  /// when the user that is using mouse device clicks on the widget.
  final bool? onlyMainButton;

  /// The defines the behavior of hit testing for the child widget.
  final HitTestBehavior behavior;

  /// The controller that manages ripple effects triggered by user gestures.
  final TouchRippleController controller;

  /// The widget is the target for detecting gestures related to touch ripple effects.
  final Widget child;

  @override
  State<TouchRippleGestureDetector> createState() => _TouchRippleGestureDetectorState();
}

class _TouchRippleGestureDetectorState extends State<TouchRippleGestureDetector> {
  /// The list defines instances of a builder function that creates GestureRecognizer objects.
  /// Instances of [GestureRecognizer] should be added and removed according to the lifecycle
  /// of the gesture detector.
  ///
  /// This keeps the context about the factory and lifecycle management clear and concise.
  final List<GestureRecognizerBuilder> _builders = [];

  /// The list defines the instances of currently active [GestureRecognizer].
  final List<GestureRecognizer> _recognizers = <GestureRecognizer>[];

  /// Returns an instance of a given [TouchRippleController] as this widget reference.
  TouchRippleController get controller => widget.controller;

  // Initializes gesture recognizer builders.
  initBuilders() {
    _builders.clear();

    if (widget.onTap != null) {
      _builders.add(() {
        late TouchRippleSpreadingEffect activeEffect;
        return TouchRippleTapGestureRecognizer(
          context: context,
          rejectBehavior: controller.context.rejectBehavior,
          onlyMainbutton: widget.onlyMainButton ?? controller.context.tapBehavior.onlyMainButton!,
          previewMinDuration: controller.context.previewDuration,
          acceptableDuration: controller.context.tappableDuration,
          onTap: (offset) {
            activeEffect = TouchRippleSpreadingEffect(
              vsync: controller.context.vsync,
              callback: widget.onTap!,
              isRejectable: false,
              baseOffset: offset,
              behavior: controller.context.tapBehavior
            );

            controller.attach(activeEffect..start());
          },
          onTapRejectable: (offset) {
            activeEffect = TouchRippleSpreadingEffect(
              vsync: controller.context.vsync,
              callback: widget.onTap!,
              isRejectable: true,
              baseOffset: offset,
              behavior: controller.context.tapBehavior
            );

            controller.attach(activeEffect..start());
          },
          onTapReject: () => activeEffect.onRejected(),
          onTapAccept: () => activeEffect.onAccepted(),
        )
        // Called when this gesture recognizer disposed.
        ..onDispose = _recognizers.remove;
      });
    }
  }

  _handlePointerDown(PointerDownEvent event) {
    // Recreates the necessary gesture recognizer to forward to
    // a new lifecycle when no gesture recognizer has been assigned.
    if (_recognizers.length <= 1) {
      _recognizers.clear();
      _recognizers.addAll([HoldingGestureRecognizer()]);
      _recognizers.addAll(_builders.map((builder) => builder.call()));
    }

    for (var r in _recognizers) {
      r.addPointer(event);
    }
  }

  _handlePointerHover(PointerHoverEvent event) {}

  @override
  void initState() {
    super.initState();

    // Initializes initial gesture recognizer builders.
    initBuilders();
  }

  @override
  void didUpdateWidget(covariant TouchRippleGestureDetector oldWidget) {
    super.didUpdateWidget(oldWidget);

    // The gesture recognizer builders needs to be rebuilt
    // when a given callback function is different or null.
    if (widget.onTap != oldWidget.onTap ||
        widget.onDoubleTap != oldWidget.onDoubleTap ||
        widget.onLongTap != oldWidget.onLongTap) {
      initBuilders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: widget.behavior,
      onPointerHover: _handlePointerHover,
      onPointerDown: _handlePointerDown,
      child: widget.child,
    );
  }
}
