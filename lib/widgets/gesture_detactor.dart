import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/behavior.dart';
import 'package:flutter_touch_ripple/components/gestures/mixins.dart';
import 'package:flutter_touch_ripple/components/gestures/recognizers.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

/// An abstract stateful widget declared to detect and callback touch events.
abstract class TouchRippleGestureDetectorWidget extends StatefulWidget {
  const TouchRippleGestureDetectorWidget({
    super.key,
  });
}

/// A custom widget declared by default to detect and callback touch events.
class TouchRippleGestureDetector extends TouchRippleGestureDetectorWidget {
  const TouchRippleGestureDetector({
    super.key,
    required this.child,
    required this.behavior, // Hit Test Behaivor
    required this.rejectBehavior,
    required this.longTapFocusStartEvent,
    this.tapPreviewMinDuration,
    this.tapableDuration,
    this.doubleTappableDuration,
    this.doubleTapHoldDuration,
    this.longTappableDuration,
    this.longTapStartDeleyDuration,
    this.onTap,
    this.onRejectableTap,
    this.onDoubleTap,
    this.onDoubleTapStart,
    this.onDoubleTapEnd,
    this.onRejectableLongTap,
    this.onLongTap,
    this.onLongTapStart,
    this.onLongTapEnd,
    this.onAccepted,
    this.onRejected,
    this.onFocusStart,
    this.onFocusEnd,
  });

  /// The [child] widget contained by the [TouchRipple] widget.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// Same as [HitTestBehavior] of [RawGestureDetector].
  final HitTestBehavior behavior;

  /// Same as [TouchRippleWidget.cancelBehavior].
  final TouchRippleRejectBehavior rejectBehavior;

  final TouchRippleLongTapFocusStartEvent longTapFocusStartEvent;

  /// Same as [TouchRippleWidget.tapPreviewMinDuration].
  final Duration? tapPreviewMinDuration;

  /// Same as [TouchRippleWidget.tapableDuration].
  final Duration? tapableDuration;

  /// Same as [TouchRippleWidget.doubleTappableDuration].
  final Duration? doubleTappableDuration;

  /// Same as [TouchRippleWidget.doubleTapHoldDuration].
  final Duration? doubleTapHoldDuration;

  /// Same as [TouchRippleWidget.longTappableDuration].
  final Duration? longTappableDuration;

  /// Same as [TouchRippleWidget.longTapStartDeleyDuration].
  final Duration? longTapStartDeleyDuration;

  final TouchRippleRecognizerCallback? onTap;

  final TouchRippleRejectableCallback? onRejectableTap;

  final TouchRippleRecognizerCountableCallback? onDoubleTap;

  final TouchRippleStateCallBack? onDoubleTapStart;

  final TouchRippleStateCallBack? onDoubleTapEnd;

  final TouchRippleRejectableCallback? onRejectableLongTap;

  final TouchRippleRecognizerCountableCallback? onLongTap;

  final TouchRippleStateCallBack? onLongTapStart;

  final TouchRippleStateCallBack? onLongTapEnd;

  final TouchRippleAcceptedCallback? onAccepted;

  final TouchRippleRejectedCallback? onRejected;

  final TouchRippleFocusStartStateCallBack? onFocusStart;

  final TouchRippleStateCallBack? onFocusEnd;

  @override
  State<TouchRippleGestureDetector> createState() =>
      _TouchRippleGestureDetectorState();
}

class _TouchRippleGestureDetectorState
    extends State<TouchRippleGestureDetector> {
  /// Returns the gestures corresponding to the given or updated status argument.
  Map<Type, GestureRecognizerFactory> createGestures() {
    final gestures = <Type, GestureRecognizerFactory>{};

    if (widget.onTap != null) {
      gestures[TouchRippleTapGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<TouchRippleTapGestureRecognizer>(
        () => TouchRippleTapGestureRecognizer(
            context: context, rejectBehavior: widget.rejectBehavior),
        (TouchRippleTapGestureRecognizer instance) {
          instance
            ..onTap = widget.onTap
            ..onAcceptedCallBack = widget.onAccepted
            ..onRejectedCallBack = widget.onRejected
            ..onRejectableCallBack = widget.onRejectableTap
            ..acceptableDuration = widget.tapableDuration
            ..previewMinDuration = widget.tapPreviewMinDuration;
        },
      );
    }
    if (widget.onDoubleTap != null) {
      gestures[TouchRippleDoubleTapGestureRecognizer] = GestureRecognizerFactoryWithHandlers<TouchRippleDoubleTapGestureRecognizer>(
        () => TouchRippleDoubleTapGestureRecognizer(
            context: context, rejectBehavior: widget.rejectBehavior),
        (TouchRippleDoubleTapGestureRecognizer instance) {
          instance
            ..doubleTappableDuration = widget.doubleTappableDuration
            ..doubleTapHoldDuration = widget.doubleTapHoldDuration
            ..onDoubleTap = widget.onDoubleTap
            ..onContinueStartCallBack = widget.onDoubleTapStart
            ..onContinueEndCallBack = widget.onDoubleTapEnd
            ..onFocusStartCallBack = widget.onFocusStart
            ..onFocusEndCallBack = widget.onFocusEnd;
        },
      );
    }
    if (widget.onRejectableLongTap != null) {
      gestures[TouchRippleLongTapGestureRecognizer] = GestureRecognizerFactoryWithHandlers<TouchRippleLongTapGestureRecognizer>(
        () => TouchRippleLongTapGestureRecognizer(
          context: context,
          rejectBehavior: widget.rejectBehavior,
          focusStartEvent: widget.longTapFocusStartEvent,
        ),
        (TouchRippleLongTapGestureRecognizer instance) {
          instance
            ..onAcceptedCallBack = widget.onAccepted
            ..onRejectedCallBack = widget.onRejected
            ..onRejectableCallBack = widget.onRejectableLongTap
            ..onLongTap = widget.onLongTap
            ..onContinueStartCallBack = widget.onLongTapStart
            ..onContinueEndCallBack = widget.onLongTapEnd
            ..longTapStartDeleyDuration = widget.longTapStartDeleyDuration
            ..longTappableDuration = widget.longTappableDuration
            ..onFocusStartCallBack = widget.onFocusStart
            ..onFocusEndCallBack = widget.onFocusEnd;
        },
      );
    }

    /// Add an empty gesture detector to keep the gesture detectors in competition.
    gestures[EmptyGestureRecognizer] = GestureRecognizerFactoryWithHandlers<EmptyGestureRecognizer>(
      () => EmptyGestureRecognizer(),
      (EmptyGestureRecognizer instance) {
        // ...
      },
    );

    return gestures;
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      behavior: widget.behavior,
      gestures: createGestures(),
      child: widget.child,
    );
  }
}
