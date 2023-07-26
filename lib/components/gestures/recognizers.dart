import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/behavior.dart';
import 'package:flutter_touch_ripple/components/gestures/base_recognizer.dart';
import 'package:flutter_touch_ripple/components/gestures/mixins.dart';





typedef TouchRippleRecognizerCallback = void Function(Offset acceptedOffset);

typedef TouchRippleRecognizerCountableCallback = bool Function(Offset acceptedOffset, int count);

/// Provides the ability to set a member variable of a extended class to its initial value when
/// a gesture is rejected or accepted, that is, when the gesture ends.
abstract class ResetableGestureRecognizer extends OneSequenceGestureRecognizer {
  @override
  void didStopTrackingLastPointer(int pointer) {
    // Initialize all previously defined values in order to
    // detect and process the gesture again.
    Future.microtask(reset);
  }
  
  /// A callback function that is called to define all the member variables of this class
  /// to their initial values if the gesture is rejected or accepted.
  @mustCallSuper
  void reset();
}

class EmptyGestureRecognizer extends OneSequenceGestureRecognizer {
  @override
  String get debugDescription => 'Empty Gesture Recognizer';

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerUpEvent) resolve(GestureDisposition.rejected);
  }
}

class TouchRippleTapGestureRecognizer extends BaseTouchRippleGestureRecognizer
      with  RejectableGestureRecognizerMixin,
            UnHoldableGestureRecognizerMixin {
  TouchRippleTapGestureRecognizer({
    required super.context,
    required super.rejectBehavior,
  });

  @override
  bool get isInterlinkable => true;

  TouchRippleRecognizerCallback? onTap;

  Duration? previewMinDuration;
  Duration? acceptableDuration;

  Timer? _previewTimer;
  Timer? _acceptableTimer;

  @override
  String get debugLabal => 'on Tap';

  @override
  void onPointerDown(PointerDownEvent event) {
    super.onPointerDown(event);
    
    if (previewMinDuration != null) {
      _previewTimer?.cancel();
      _previewTimer = Timer(previewMinDuration!, () {
        onRejectable(super.currentPointerOffset);
      });
    }
    
    assert(acceptableDuration != Duration.zero);
    if (acceptableDuration != null) {
      _acceptableTimer?.cancel();
      _acceptableTimer = Timer(acceptableDuration!, reject);
    }
  }

  @override
  void onPointerUp(PointerUpEvent event) {
    super.onPointerUp(event);

    _previewTimer?.cancel();
    _acceptableTimer?.cancel();
  }

  @override
  void onAccept() {
    onTap?.call(super.currentPointerOffset);
  }

  @override
  void reset() {
    super.reset();

    /// Disposes actived timers
    _previewTimer?.cancel();
    _previewTimer = null;
    _acceptableTimer?.cancel();
    _acceptableTimer = null;
  }
}

class TouchRippleDoubleTapGestureRecognizer extends BaseTouchRippleGestureRecognizer
      with  HoldableGestureRecognizerMixin,
            CountableGestureRecognizerMixin,
            FocusableGestureRecognizerMixin {
      
  TouchRippleDoubleTapGestureRecognizer({
    required super.context,
    required super.rejectBehavior,
  });

  @override
  String get debugLabal => 'on Double Tap';
  
  TouchRippleRecognizerCountableCallback? onDoubleTap;

  Duration? doubleTappableDuration;
  Duration? doubleTapHoldDuration;
  
  Timer? _doubleTappableTimer;
  Timer? _doubleTapHoldTimer;

  int _tapCount = 0;

  int get _doubleTapCount => _tapCount == 0 ? 0 : _tapCount - 1;

  @override
  void onContinueStart() {
    super.onContinueStart();
    super.onFocusStart(this);
  }

  @override
  void onContinueEnd() {
    super.onContinueEnd();
    super.onFocusEnd();
    super.releaseAll();
  }

  @override
  void onPointerDown(PointerDownEvent event) {
    super.onPointerDown(event);
    super.hold();

    _tapCount++;

    assert(
      doubleTappableDuration != null,
      'The [_doubleTappableTimer] must be initialised before the [doubleTappableDuration] can be Initialised.'
    );
    assert(
      doubleTapHoldDuration != null,
      'The [_doubleTapHoldTimer] must be initialised before the [doubleTapHoldDuration] can be Initialised.'
    );
    if (_doubleTapCount == 1) onContinueStart();
    if (_doubleTapCount > 0) {
      final isContinueable = onDoubleTap?.call(currentPointerOffset, _doubleTapCount);

      accept();
      if (isContinueable ?? false) {
        onContinued();

        _doubleTappableTimer?.cancel();
        _doubleTappableTimer = null;

        _doubleTapHoldTimer?.cancel();
        _doubleTapHoldTimer = Timer(doubleTapHoldDuration!, onContinueEnd);
      } else {
        onContinueEnd();
      }
    } else {
      _doubleTappableTimer?.cancel();
      _doubleTappableTimer = Timer(doubleTappableDuration!, () {
        super.reject();
        super.releaseAll();
      });
    }
  }

  @override
  void reset() {
    super.reset();
    
    _tapCount = 0;
    _doubleTappableTimer?.cancel();
    _doubleTappableTimer = null;
    _doubleTapHoldTimer?.cancel();
    _doubleTapHoldTimer = null;
  }
}

class TouchRippleLongTapGestureRecognizer extends BaseTouchRippleGestureRecognizer
    with  UnHoldableGestureRecognizerMixin,
          RejectableGestureRecognizerMixin,
          CountableGestureRecognizerMixin,
          FocusableGestureRecognizerMixin {
                
  TouchRippleLongTapGestureRecognizer({
    required super.context,
    required super.rejectBehavior,
    required this.focusStartEvent,
  });

  @override
  bool get isInterlinkable => true;

  TouchRippleLongTapFocusStartEvent focusStartEvent;

  @override
  String get debugLabal => 'on Long Tap';

  TouchRippleRecognizerCountableCallback? onLongTap;

  Duration? longTappableDuration;
  Duration? longTapStartDeleyDuration;

  Timer? _longTappableTimer;
  Timer? _longTapStartDeleyTimer;
  
  int _longTapCount = 0;

  @override
  void onContinueStart() {
    super.onContinueStart();

    if (focusStartEvent == TouchRippleLongTapFocusStartEvent.onContinueStart) {
      super.onFocusStart(this);
    }
  }

  @override
  void onContinueEnd() {
    super.onContinueEnd();
    super.onFocusEnd();
  }

  @override
  void onRejectable(Offset rejectableOffset) {
    super.onRejectable(rejectableOffset);

    if (focusStartEvent == TouchRippleLongTapFocusStartEvent.onRejectable) {
      super.onFocusStart(this);
    }
  }

  @override
  void onAccept() {
    assert(
      true,
      'Long tap gestures can only be accepted when the gesture is in a rejectable state,'
      'so they can never be accepted under normal circumstances when'
      'the gesture is not in a rejectable state.'
    );
  }

  @override
  void onAccepted() {
    super.onAccepted();
          onContinueEnd();
  }

  void continueLongTap() {
    super.onRejected();

    void longTappable() {
      final pointerOffset = currentPointerOffset;
      final isContinue = onLongTap?.call(currentPointerOffset, ++_longTapCount);
        
      assert(isContinue != null);
      if (isContinue ?? false) {
        onRejectable(pointerOffset);

        _longTappableTimer?.cancel();
        _longTappableTimer = Timer(longTappableDuration!, continueLongTap);
      } else {
        accept();
      }
    }
    longTappable();
  }

  void startLongTappable() {
    onRejectable(currentPointerOffset);
    
    _longTappableTimer?.cancel();
    _longTappableTimer = Timer(longTappableDuration!, () {
      onContinueStart();
      continueLongTap();
    });
  }

  @override
  void onPointerDown(PointerDownEvent event) {
    super.onPointerDown(event);

    _longTapStartDeleyTimer?.cancel();
    _longTapStartDeleyTimer = Timer(longTapStartDeleyDuration!, startLongTappable);
  }

  @override
  void acceptGesture(int pointer) {
    super.acceptGesture(pointer);
    super.onRejected();
  }

  @override
  void rejectGesture(int pointer) {
    super.rejectGesture(pointer);

    if (rejectableState != null) super.onFocusEnd();
  }

  @override
  void onPointerUp(PointerUpEvent event) {
    super.onPointerUp(event);

    if(_longTapCount == 0) {
      reject();
      onContinueEnd();
    } else {
      accept();
    }

    _longTapCount == 0 ? reject() : accept();
  }

  @override
  void reset() {
    super.reset();

    _longTapCount = 0;
    _longTappableTimer?.cancel();
    _longTappableTimer = null;
    _longTapStartDeleyTimer?.cancel();
    _longTapStartDeleyTimer = null;
  }
}

class TouchRippleHorizontalDragGestureRecognizer extends BaseTouchRippleGestureRecognizer
    with  UnHoldableGestureRecognizerMixin,
          FocusableGestureRecognizerMixin {

  TouchRippleHorizontalDragGestureRecognizer({
    required super.context,
  }) : super(rejectBehavior: TouchRippleRejectBehavior.none);
  
  @override
  String get debugLabal => 'on Horizontal Drag';

  bool isAccepted = false;

  @override
  void onFocusStart(BaseTouchRippleGestureRecognizer instance) {
    super.onFocusStart(instance);
    super.accept();
  }

  @override
  void accept() {
    super.accept();

    isAccepted = true;
  }

  @override
  void onPointerMove(PointerMoveEvent event) {
    super.onPointerMove(event);

    if (pointerMoveDistance.dx.abs() >= kTouchSlop) onFocusStart(this);
  }

  @override
  void onPointerUp(PointerUpEvent event) {
    super.onPointerUp(event);

    if (isAccepted) onFocusEnd();
  }
  
  @override
  void reset() {
    super.reset();

    isAccepted = false;
  }
}