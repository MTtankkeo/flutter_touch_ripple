import "dart:io";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_touch_ripple/flutter_touch_ripple.dart";
import "package:flutter_touch_ripple/widgets/touch_ripple_pointer_listener.dart";

/// Signature for the builder function that creates an instance of [GestureRecognizer].
typedef GestureRecognizerBuilder<T extends GestureRecognizer> = T Function();

/// This widget detects user gestures, notifies the relevant controller that
/// manages touch ripple effects, and delegates the handling to it.
class TouchRippleGestureDetector<T extends dynamic> extends StatefulWidget {
  const TouchRippleGestureDetector({
    super.key,
    this.onTap,
    this.onTapAsync,
    this.onTapAsyncStart,
    this.onTapAsyncEnd,
    this.onDoubleTap,
    this.onDoubleTapConsecutive,
    this.onDoubleTapStart,
    this.onDoubleTapEnd,
    this.onLongTap,
    this.onLongTapStart,
    this.onLongTapEnd,
    this.onFocusStart,
    this.onFocusEnd,
    this.onHoverStart,
    this.onHoverEnd,
    this.onlyMainButton,
    this.behavior = HitTestBehavior.opaque,
    this.cursor = MouseCursor.defer,
    required this.controller,
    required this.child,
  }) : assert(onTap != null ? onTapAsync == null : true);

  /// The callback function is called when the user taps or clicks.
  final VoidCallback? onTap;

  /// The callback function is called when the user taps or clicks. but this function
  /// ensures that the touch ripple effect remains visible until the asynchronous
  /// operation is completed and prevents additional events during that time.
  final TouchRippleAsyncCallback<T>? onTapAsync;

  /// The callback function is called when an asynchronous operation is initiated by
  /// a tap. It provides the associated Future instance for the ongoing operation.
  final TouchRippleAsyncNotifyCallback<T>? onTapAsyncStart;

  /// The callback function is called when the result of the asynchronous operation
  /// is ready. It allows handling the result once the operation is complete.
  final TouchRippleAsyncResultCallback<T>? onTapAsyncEnd;

  /// The callback function is called when the user double taps or double clicks.
  final VoidCallback? onDoubleTap;

  /// The callback function is called to determine whether consecutive double taps
  /// should continue. It returns a [bool] indicating whether the long tap event
  /// should continue after the initial occurrence.
  final TouchRippleContinuableCallback? onDoubleTapConsecutive;

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

  /// The callback function is a lifecycle callback for focus touch ripple events.
  /// It is called when a focus touch event starts, allowing for the initiation
  /// of actions based on the beginning of the focus event sequence.
  final VoidCallback? onFocusStart;

  /// The callback function is a lifecycle callback for focus touch ripple events.
  /// It is called when a focus touch event ends, providing the advantage of
  /// knowing when a series of focus touch ripple events has concluded.
  final VoidCallback? onFocusEnd;

  /// The callback function called when the cursor begins hovering over the widget. (by [MouseRegion])
  /// This function allows for the initiation of actions based on the hover interaction.
  /// This function is not called in touch-based environments yet.
  final VoidCallback? onHoverStart;

  /// The callback function called when the cursor begins to leave the widget. (by [MouseRegion])
  /// This function allows for actions to be executed based on the end of the hover interaction.
  /// This function is not called in touch-based environments yet.
  final VoidCallback? onHoverEnd;

  /// The boolean that is whether only the main button is recognized as a gesture
  /// when the user that is using mouse device clicks on the widget.
  final bool? onlyMainButton;

  /// The defines the behavior of hit testing for the child widget.
  final HitTestBehavior behavior;

  /// The hover mouse cursor type, and default value is [MouseCursor.defer].
  final MouseCursor cursor;

  /// The controller that manages ripple effects triggered by user gestures.
  final TouchRippleController controller;

  /// The widget is the target for detecting gestures related to touch ripple effects.
  final Widget child;

  @override
  State<TouchRippleGestureDetector> createState() => _TouchRippleGestureDetectorState<T>();
}

class _TouchRippleGestureDetectorState<T> extends State<TouchRippleGestureDetector<T>> {
  /// The list defines instances of a builder function that creates GestureRecognizer objects.
  /// Instances of [GestureRecognizer] should be added and removed according to the lifecycle
  /// of the gesture detector.
  ///
  /// This keeps the context about the factory and lifecycle management clear and concise.
  final List<GestureRecognizerBuilder> _builders = [];

  /// The list defines the instances of currently active [GestureRecognizer].
  final List<GestureRecognizer> _recognizers = <GestureRecognizer>[];

  /// Returns the instance of a given [TouchRippleController] as this widget reference.
  TouchRippleController get controller => widget.controller;

  /// Returns the instance of [TouchRippleContext] of a given [controller].
  TouchRippleContext get rippleContext => controller.context;

  /// Called when the focus is started by the gesture recognizers.
  onFocusStart() {
    widget.onFocusStart?.call();

    var effect = controller.getEffectByKey<TouchRippleSolidEffect>("focus");
    if (effect == null && rippleContext.useFocusEffect) {
      effect = TouchRippleSolidEffect(
        vsync: rippleContext.vsync,
        color: controller.context.focusColor,
        animation: rippleContext.focusAnimation,
      );

      controller.attachByKey("focus", effect);
    }

    effect?.fadeIn();
  }

  /// Called when the focus is ended by the gesture recognizers that are focus active.
  onFocusEnd() {
    widget.onFocusEnd?.call();
    controller.getEffectByKey<TouchRippleSolidEffect>("focus")?.fadeOut();
  }

  /// Called when the hover is started by [MouseRegion] widget.
  onHoverStart() {
    widget.onHoverStart?.call();

    var effect = controller.getEffectByKey<TouchRippleSolidEffect>("hover");
    if (effect == null && rippleContext.useHoverEffect) {
      effect = TouchRippleSolidEffect(
        vsync: rippleContext.vsync,
        color: controller.context.hoverColor,
        animation: rippleContext.hoverAnimation,
      );

      controller.attachByKey("hover", effect);
    }

    effect?.fadeIn();
  }

  /// Called when the hover is ended by [MouseRegion] widget.
  onHoverEnd() {
    widget.onHoverEnd?.call();
    controller.getEffectByKey<TouchRippleSolidEffect>("hover")?.fadeOut();
  }

  // Initializes gesture recognizer builders.
  initBuilders() {
    _builders.clear();

    final isTappable = widget.onTap != null;
    final isTapAsyncable = widget.onTapAsync != null;
    final isDoubleTappable = widget.onDoubleTap != null;
    final isLongTappable = widget.onLongTap != null;

    // If there is a gesture competitor other than itself,
    // the effect cannot be previewed for tap effect.
    final previewMinDuration = isDoubleTappable || isLongTappable
        ? Duration.zero
        : rippleContext.previewDuration;

    if (isTappable) {
      _builders.add(() {
        late TouchRippleSpreadingEffect activeEffect;

        assert(rippleContext.tapBehavior.onlyMainButton != null);
        return TouchRippleTapGestureRecognizer(
          context: rippleContext,
          onlyMainButton: widget.onlyMainButton ?? rippleContext.tapBehavior.onlyMainButton!,
          previewMinDuration: previewMinDuration,
          acceptableDuration: rippleContext.tappableDuration,
          onTap: (offset) {
            activeEffect = TouchRippleSpreadingEffect( 
              context: rippleContext,
              callback: widget.onTap!,
              isRejectable: false,
              baseOffset: offset,
              behavior: rippleContext.tapBehavior
            );

            controller.attach(activeEffect..start());
          },
          onTapRejectable: (offset) {
            activeEffect = TouchRippleSpreadingEffect(
              context: rippleContext,
              callback: widget.onTap!,
              isRejectable: true,
              baseOffset: offset,
              behavior: rippleContext.tapBehavior
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

    if (isTapAsyncable) {
      _builders.add(() {
        late TouchRippleSpreadingEffect activeEffect;

        // The asynchronous processing result.
        late T result;

        // The ripple effect will not fade-out until the asynchronous process is complete (by rejectable),
        // And the effect instance delegates the invocation of the callback function to delay the
        // lifecycle callback function call based on the `eventCallBackableMinPercent` option.
        void attachEffect(Offset offset) {
          activeEffect = TouchRippleSpreadingEffect( 
            context: rippleContext,
            callback: () => widget.onTapAsyncEnd?.call(result),
            isRejectable: true,
            baseOffset: offset,
            behavior: rippleContext.tapBehavior
          );

          controller.attach(activeEffect..start());
        }

        // Starts asynchronous processing about a given callback.
        void performAsync() {
          final instance = widget.onTapAsync!()..then((_result) {
            result = _result;
            activeEffect.onAccepted();
          });

          widget.onTapAsyncStart?.call(instance);
        }

        assert(rippleContext.tapBehavior.onlyMainButton != null);
        return TouchRippleTapGestureRecognizer(
          context: rippleContext,
          onlyMainButton: widget.onlyMainButton ?? rippleContext.tapBehavior.onlyMainButton!,
          previewMinDuration: previewMinDuration,
          acceptableDuration: rippleContext.tappableDuration,
          onTap: (offset) {
            attachEffect(offset);
            performAsync();
          },
          onTapRejectable: attachEffect,
          onTapReject: () => activeEffect.onRejected(),
          onTapAccept: performAsync,
        )
        // Called when this gesture recognizer disposed.
        ..onDispose = _recognizers.remove;
      });
    }

    if (isDoubleTappable) {
      _builders.add(() {
        assert(rippleContext.doubleTapBehavior.onlyMainButton != null);
        assert(widget.onDoubleTapStart != null ? widget.onDoubleTapConsecutive != null : true);
        assert(widget.onDoubleTapEnd != null ? widget.onDoubleTapConsecutive != null : true);
        return TouchRippleDoubleTapGestureRecognizer(
          context: rippleContext,
          onlyMainButton: widget.onlyMainButton ?? rippleContext.doubleTapBehavior.onlyMainButton!,
          acceptableDuration: rippleContext.doubleTappableDuration,
          aliveDuration: rippleContext.doubleTapAliveDuration,
          onDoubleTap: (offset, count) {
            controller.attach(TouchRippleSpreadingEffect(
              context: rippleContext,
              callback: widget.onDoubleTap!,
              isRejectable: false,
              baseOffset: offset,
              behavior: rippleContext.doubleTapBehavior
            )..start());

            return widget.onDoubleTapConsecutive?.call(count) ?? false;
          },
          onDoubleTapStart: widget.onDoubleTapStart,
          onDoubleTapEnd: widget.onDoubleTapEnd
        )
        ..onFocusStart = onFocusStart
        ..onFocusEnd = onFocusEnd
        ..onDispose = _recognizers.remove;
      });
    } else {
      assert(widget.onDoubleTapConsecutive == null);
      assert(widget.onDoubleTapStart == null);
      assert(widget.onDoubleTapEnd == null);
    }

    if (isLongTappable) {
      _builders.add(() {
        late TouchRippleSpreadingEffect activeEffect;

        assert(rippleContext.longTapBehavior.onlyMainButton != null);
        assert(rippleContext.longTapBehavior.eventCallBackableMinPercent == 0);
        return TouchRippleLongTapGestureRecognizer(
          context: rippleContext,
          onlyMainButton: widget.onlyMainButton ?? rippleContext.longTapBehavior.onlyMainButton!,
          delayDuration: rippleContext.longTappableDuration,
          cycleDuration: rippleContext.longTapCycleDuration,
          focusTiming: rippleContext.focusTiming,
          acceptableDuration: rippleContext.longTapBehavior.spreadDuration!,
          onLongTap: widget.onLongTap!,
          onLongTapRejectable: (offset) {
            activeEffect = TouchRippleSpreadingEffect(
              context: rippleContext,
              callback: () {},
              isRejectable: true,
              baseOffset: offset,
              behavior: rippleContext.longTapBehavior
            );

            controller.attach(activeEffect..start());
          },
          onLongTapReject: () => activeEffect.onRejected(),
          onLongTapAccept: () => activeEffect.onAccepted(),
          onLongTapStart: widget.onLongTapStart,
          onLongTapEnd: widget.onLongTapEnd
        )
        ..onFocusStart = onFocusStart
        ..onFocusEnd = onFocusEnd
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

  @override
  void initState() {
    super.initState();

    // Initializes initial gesture recognizer builders.
    initBuilders();
  }

  @override
  void didUpdateWidget(covariant TouchRippleGestureDetector<T> oldWidget) {
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
    final listener = TouchRipplePointerListener(
      behavior: widget.behavior,
      onPointerDown: _handlePointerDown,
      child: widget.child,
    );

    /// If a user is a touch-based device, not need to define a MouseRegion widget.
    /// because flutter does not yet provide the life cycle about hover event of
    /// touch-based environments.
    if (Platform.isFuchsia || Platform.isAndroid || Platform.isIOS) {
      return listener;
    }

    return MouseRegion(
      onEnter: (_) => onHoverStart(),
      onExit: (_) => onHoverEnd(),
      cursor: widget.cursor,
      child: listener,
    );
  }
}
