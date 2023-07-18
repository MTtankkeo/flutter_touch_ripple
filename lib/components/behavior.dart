import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/interfaces/copy_pasteable.dart';





/// Defines the behavior of a touch ripple when it overlaps.
enum TouchRippleOverlapBehavior {
  /// This value defines that the touch ripples should overlap.
  overlappable,
  /// If the effects overlap, the previous touch effect will be canceled and
  /// the should be added to the stack will be added.
  cancel,
  /// If the effects overlap, ignore and cancel the event until the previous touch effect disappears.
  ignoring,
}

/// Defines behavior for which the gesture is rejected.
enum TouchRippleRejectBehavior {
  /// No specific task is performed when the gesture is canceled.
  none,
  /// Once the pointer is detected, the event is canceled if the pointer
  /// movement distance is greater than or equal to [kTouchSlop].
  touchSlop,
  /// Once the pointer is detected, the event is canceled if the pointer position
  /// is outside the position occupied by the widget.
  leave,
}

/// Defines the task when the gesture is cancelled.
enum TouchRippleCancelledBehavior {
  /// No specific task is performed when the gesture is canceled.
  none,
  /// The spread animation of the touch ripple effect is stopped when
  /// the gesture is canceled.
  stopSpread,
  /// The spread animation of the touch ripple effect is reversed when
  /// the gesture is canceled.
  reverseSpread,
}

enum TouchRippleLongTapFocusStartEvent {
  /// The considered to be in focus when it is in a continuable state.
  onContinueStart,
  /// The situation that defines whether it is a long tap is considered the focus state.
  onRejectable,
}

/*
enum TouchRippleLongTapContinueBehavior {
  none,
  fadeOutEnd,
  applyStartDeley,
}
*/

/// A class declared to define the basic behavior of touch ripple.
class TouchRippleBehavior extends CopyPasteable<TouchRippleBehavior> {
  const TouchRippleBehavior({
    this.overlap,
    this.lowerPercent,
    this.upperPercent,
    this.fadeLowerPercent,
    this.fadeUpperPercent,
    this.eventCallBackableMinPercent,
    this.spreadDuration,
    this.spreadCurve,
    this.fadeInDuration,
    this.fadeInCurve,
    this.fadeOutDuration,
    this.fadeOutCurve,
    this.canceledDuration,
    this.canceledCurve,
  }) :  assert(lowerPercent != null ? lowerPercent <= 1 && lowerPercent >= 0 : true, 'The [lowerPercent] must be defined between 0 and 1'),
        assert(upperPercent != null ? upperPercent <= 1 && upperPercent >= 0 : true, 'The [upperPercent] must be defined between 0 and 1'),
        assert(
          lowerPercent != null ? (upperPercent != null ? upperPercent >= lowerPercent : true) : true,
          '[upperPercent] must be greater than [lowerPercent].'
        ),
        assert(eventCallBackableMinPercent != null ? eventCallBackableMinPercent <= 1 && eventCallBackableMinPercent >= 0 : true, 'The [upperPercent] must be defined between 0 and 1'),
        assert(
          eventCallBackableMinPercent != null ? (lowerPercent != null ? eventCallBackableMinPercent >= lowerPercent : true) : true,
          '[eventCallBackMinPercent] must be greater than [lowerPercent].'
          'If it is less, the event cannot be called back.'
        ),
        assert(fadeLowerPercent != null ? fadeLowerPercent <= 1 && fadeLowerPercent >= 0 : true, 'The [fadeLowerPercent] must be defined between 0 and 1'),
        assert(fadeUpperPercent != null ? fadeUpperPercent <= 1 && fadeUpperPercent >= 0 : true, 'The [fadeUpperPercent] must be defined between 0 and 1'),
        assert(
          fadeLowerPercent != null ? (fadeUpperPercent != null ? fadeUpperPercent >= fadeLowerPercent : true) : true,
          '[fadeUpperPercent] must be greater than [fadeLowerPercent].'
        );

  /// Defines the behavior when the effect is overlapped.
  final TouchRippleOverlapBehavior? overlap;
  
  /// Defines in decimal form ranging from 0 to 1,
  /// at what point the spread animation of the touch ripple effect will be started.
  final double? lowerPercent;

  /// Defines in decimal form ranging from 0 to 1,
  /// at what point the spread animation of the touch ripple effect will be ended.
  final double? upperPercent;

  /// Defines in decimal form ranging from 0 to 1,
  /// at what point the fade animation of the touch ripple effect will be started.
  final double? fadeLowerPercent;

  /// Defines in decimal form ranging from 0 to 1,
  /// at what point the fade animation of the touch ripple effect will be ended.
  final double? fadeUpperPercent;

  /// Defines the point in the spread animation of the touch ripple effect
  /// when the registered event callback function can be called.
  /// 
  /// For example,
  /// if the user is about to click to move the page,
  /// you don't want the event callback function to be called before
  /// the effect has fully spread, causing the page to move.
  final double? eventCallBackableMinPercent;

  /// Defines the duration of the touch ripple spread animation.
  final Duration? spreadDuration;

  /// Defines the curve of the touch ripple spread curved animation.
  final Curve? spreadCurve;

  /// Defines the duration of the touch ripple fade-in of fade animation.
  final Duration? fadeInDuration;

  /// Defines the curve of the touch ripple fade-in of fade curved animation.
  final Curve? fadeInCurve;

  /// Defines the duration of the touch ripple fade-out of fade animation.
  final Duration? fadeOutDuration;

  /// Defines the curve of the touch ripple fade-out of fade curved animation.
  final Curve? fadeOutCurve;
  
  /// Defines the duration for the touch ripple effect
  /// to fade out when it is interrupted by a touch ripple overlap behavior.
  /// 
  /// See also:
  /// - This duration can be defined as zero.
  final Duration? canceledDuration;

  /// Defines the curve of the fade out curve animation when
  /// the touch ripple effect is cancelled midway by the touch ripple overlap behavior.
  final Curve? canceledCurve;

  @override
  TouchRippleBehavior copyWith({
    TouchRippleOverlapBehavior? overlap,
    double? lowerPercent,
    double? upperPercent,
    double? fadeLowerPercent,
    double? fadeUpperPercent,
    double? eventCallBackableMinPercent,
    Duration? spreadDuration,
    Curve? spreadCurve,
    Duration? fadeInDuration,
    Curve? fadeInCurve,
    Duration? fadeOutDuration,
    Curve? fadeOutCurve,
    Duration? canceledDuration,
  }) {
    return TouchRippleBehavior(
      overlap: overlap ?? this.overlap,
      lowerPercent: lowerPercent ?? this.lowerPercent,
      upperPercent: upperPercent ?? this.upperPercent,
      fadeLowerPercent: fadeLowerPercent ?? this.fadeLowerPercent,
      fadeUpperPercent: fadeUpperPercent ?? this.fadeUpperPercent,
      eventCallBackableMinPercent: eventCallBackableMinPercent ?? this.eventCallBackableMinPercent,
      spreadDuration: spreadDuration ?? this.spreadDuration,
      spreadCurve: spreadCurve ?? this.spreadCurve,
      fadeInDuration: fadeInDuration ?? this.fadeInDuration,
      fadeInCurve: fadeInCurve ?? this.fadeInCurve,
      fadeOutDuration: fadeOutDuration ?? this.fadeOutDuration,
      fadeOutCurve: fadeOutCurve ?? this.fadeOutCurve,
      canceledDuration: canceledDuration ?? this.canceledDuration,
      canceledCurve: canceledCurve ?? canceledCurve,
    );
  }

  @override
  TouchRippleBehavior pasteWith(TouchRippleBehavior object) {
    return TouchRippleBehavior(
      overlap: object.overlap ?? overlap,
      lowerPercent: object.lowerPercent ?? lowerPercent,
      upperPercent: object.upperPercent ?? upperPercent,
      fadeLowerPercent: object.fadeLowerPercent ?? fadeLowerPercent,
      fadeUpperPercent: object.fadeUpperPercent ?? fadeUpperPercent,
      eventCallBackableMinPercent: object.eventCallBackableMinPercent ?? eventCallBackableMinPercent,
      spreadDuration: object.spreadDuration ?? spreadDuration,
      spreadCurve: object.spreadCurve ?? spreadCurve,
      fadeInDuration: object.fadeInDuration ?? fadeInDuration,
      fadeInCurve: object.fadeInCurve ?? fadeInCurve,
      fadeOutDuration: object.fadeOutDuration ?? fadeOutDuration,
      fadeOutCurve: object.fadeOutCurve ?? fadeOutCurve,
      canceledDuration: object.canceledDuration ?? canceledDuration,
      canceledCurve: object.canceledCurve ?? canceledCurve,
    );
  }
}