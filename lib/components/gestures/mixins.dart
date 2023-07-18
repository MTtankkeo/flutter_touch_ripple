import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/gestures/base_recognizer.dart';
import 'package:flutter_touch_ripple/components/gestures/recognizers.dart';
import 'package:flutter_touch_ripple/components/states.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';





/// The given [acceptedOffset] defines the pointer offset that was defined
/// after the gesture was accepted.
typedef TouchRippleAcceptedCallback = void Function(TouchRippleState acceptedState);

typedef TouchRippleRejectedCallback = void Function(TouchRippleState rejectedState);

typedef TouchRippleRejectableCallback = TouchRippleState Function(Offset rejectableOffset);

/// It provides functionality to continuously track the defined pointers
/// to prevent the gesture from being rejected.
/// 
/// Example:
/// ```dart
/// class TouchRippleDoubleTapGestureRecognizer extends BaseTouchRippleGestureRecognizer {
///   @override
///   void addPointer(PointerDownEvent event) {
///     super.addPointer(event);
///     // Hold the tracking state even if the pointer currently being tracked is not detected.
///     hold();
///   }
/// }
/// ```
mixin HoldableGestureRecognizerMixin on ResetableGestureRecognizer {
  /// The pointer ID currently being tracking.
  int? _currentPointer;
  
  /// Defines a pointer IDs to keep track of so that gestures are not rejected.
  final List<int> _holdedPointerList = [];

  @override
  void addPointer(PointerDownEvent event) {
    super.addPointer(event);

    _currentPointer = event.pointer;
  }

  /// Defines to keep the tracking state even if the pointer currently
  /// being tracked is not detected.
  void hold() {
    assert(_currentPointer != null);
    GestureBinding.instance.gestureArena.hold(_currentPointer!);

    _holdedPointerList.add(_currentPointer!);
  }

  /// Release all currently tracking pointers.
  void releaseAll() {
    if (_holdedPointerList.isEmpty) return;

    for (int pointer in _holdedPointerList) {
      stopTrackingPointer(pointer);
      GestureBinding.instance.gestureArena.release(pointer);
    }

    _holdedPointerList.clear();
  }

  @override
  void reset() {
    super.reset();

    _currentPointer = null;
    _holdedPointerList.clear();
  }
}

mixin UnHoldableGestureRecognizerMixin on ResetableGestureRecognizer {
  bool isAddedPointer = false;
  
  @override
  void addPointer(PointerDownEvent event) {
    if (isAddedPointer == false) {
      super.addPointer(event);
    }
    isAddedPointer = true;
  }

  @override
  void acceptGesture(int pointer) {
    super.acceptGesture(pointer);
    super.stopTrackingPointer(pointer);
  }

  @override
  void rejectGesture(int pointer) {
    super.rejectGesture(pointer);
    super.stopTrackingPointer(pointer);
  }

  @override
  void reset() {
    super.reset();
    
    isAddedPointer = false;
  }
}

mixin RejectableGestureRecognizerMixin on ResetableGestureRecognizer {
  TouchRippleAcceptedCallback? onAcceptedCallBack;
  TouchRippleRejectedCallback? onRejectedCallBack;
  TouchRippleRejectableCallback? onRejectableCallBack;
  
  bool onAcceptedCalled = false;
  bool onRejectedCalled = false;
  bool onRejectableCalled = false;

  TouchRippleState? rejectableState;

  bool get isInterlinkable;

  /*
   * Rejectable gesture life cycles
  */

  @protected
  void onAccepted() {
    onAcceptedCalled = true;

    assert(rejectableState != null, 'If the state is rejectable, the touch ripple state must be defined.');
    if (rejectableState != null) onAcceptedCallBack?.call(rejectableState!);
  }

  @protected
  void onRejected() {
    onRejectedCalled = true;
    
    assert(rejectableState != null, 'If the state is rejectable, the touch ripple state must be defined.');
    if (rejectableState != null) onRejectedCallBack?.call(rejectableState!);
  }

  @protected
  void onRejectable(Offset rejectableOffset) {
    onRejectableCalled = true;
    rejectableState = onRejectableCallBack?.call(rejectableOffset);
  }

  void onAccept();

  @override
  void reset() {
    super.reset();

    onAcceptedCalled = false;
    onRejectedCalled = false;
    onRejectableCalled = false;

    rejectableState = null;
  }

  @override
  void acceptGesture(int pointer) {
    super.acceptGesture(pointer);

    onRejectableCalled ? onAccepted() : onAccept();
  }

  @override
  void rejectGesture(int pointer) {
    super.rejectGesture(pointer);

    if (onRejectableCalled) onRejected();
  }
}





typedef TouchRippleFocusStartStateCallBack = void Function(BaseTouchRippleGestureRecognizer recognizer);

mixin FocusableGestureRecognizerMixin on ResetableGestureRecognizer {
  TouchRippleFocusStartStateCallBack? onFocusStartCallBack;
  TouchRippleStateCallBack? onFocusEndCallBack;
  
  @mustCallSuper
  void onFocusStart(
    BaseTouchRippleGestureRecognizer instance,
  ) => onFocusStartCallBack?.call(instance);

  @mustCallSuper
  void onFocusEnd() => onFocusEndCallBack?.call();
}

mixin CountableGestureRecognizerMixin on ResetableGestureRecognizer {
  TouchRippleStateCallBack? onContinueCallBack;
  TouchRippleStateCallBack? onContinueStartCallBack;
  TouchRippleStateCallBack? onContinueEndCallBack;

  @mustCallSuper
  void onContinued() => onContinueCallBack?.call();

  @mustCallSuper
  void onContinueStart() => onContinueStartCallBack?.call();
  
  @mustCallSuper
  void onContinueEnd() => onContinueEndCallBack?.call();
}