import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_context.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_event.dart';

/// Signature for the callback function that is called when a [GestureRecognizer] disposed.
typedef GestureRecognizerDisposeCallback = void Function(GestureRecognizer instance);

/// The abstract class that defines the touch ripple gesture base behavior,
/// which is a basic and essential behavior.
abstract class TouchRippleGestureRecognizer extends OneSequenceGestureRecognizer {
  TouchRippleGestureRecognizer({
    required this.context,
    required this.onlyMainButton,
  });

  final TouchRippleContext context;

  /// The boolean that is whether only the main button is recognized as a gesture
  /// when the user that is using mouse device clicks on the widget.
  final bool onlyMainButton;

  /// The callback function is called when this gesture recognizer
  /// disposed in the memory by flutter SDK and library.
  GestureRecognizerDisposeCallback? onDispose;

  @override
  String get debugDescription => "touch ripple event callBack: $debugLabal";

  String get debugLabal;

  /// The boolean that defines whether the gesture is accepted.
  bool isAccepted = false;

  /// The pointer position when the pointer was first detected is defined.
  Offset? _pointerDownOffset;

  /// The updated pointer position since the pointer went down is defined.
  Offset? _pointerMoveOffset;

  /// Returns the current referenceable pointer offset.
  Offset get currentPointerOffset => _pointerMoveOffset ?? (_pointerDownOffset ?? Offset.zero);

  Offset get originOffset {
    switch (context.origin) {
      case TouchRippleOrigin.pointer_down: return _pointerDownOffset!;
      case TouchRippleOrigin.pointer_move: return currentPointerOffset;
      case TouchRippleOrigin.center: return Offset(size.width / 2, size.height / 2);
    }
  }

  /// Returns the distance the pointer has moved since it was detected.
  Offset get pointerMoveDistance =>
      (_pointerDownOffset ?? Offset.zero) - (_pointerMoveOffset ?? Offset.zero);

  /// Returns the render box corresponding to the initialized build context.
  RenderBox? get _renderBox => context.context.findRenderObject() as RenderBox?;

  /// Returns the current intrinsic size of the rendered widget.
  Size get size => _renderBox?.size ?? Size.zero;

  /// Returns whether to reject the gesture based on the given pointer offset.
  bool rejectByOffset(Offset offset) {
    if (isAccepted) return false;
    if (context.rejectBehavior == TouchRippleRejectBehavior.none) return false;
    if (context.rejectBehavior == TouchRippleRejectBehavior.leave) {
      return !(_renderBox?.hitTest(BoxHitTestResult(), position: offset) ?? false);
    }

    // is TouchRippleCancalBehavior.touchSlop
    return pointerMoveDistance.dx.abs() > kTouchSlop
        || pointerMoveDistance.dy.abs() > kTouchSlop;
  }

  /// Defines the values needed to process the gesture and
  /// calls the callback function corresponding to the given event.
  ///
  /// Will reject the gesture on its own,
  /// constantly referencing whether it must be rejected when pointer moved.
  @override
  void handleEvent(PointerEvent event) {
    // Ignores right mouse button click events if only the left button is desired.
    if (onlyMainButton && event.buttons == kSecondaryMouseButton) {
      return reject();
    }

    if (event is PointerDownEvent) _pointerDownOffset = event.localPosition;
    if (event is PointerMoveEvent) _pointerMoveOffset = event.localPosition;

    // Calls the callback function corresponding to the given event.
    if (event is PointerDownEvent) onPointerDown(event);
    if (event is PointerMoveEvent) {
      if (rejectByOffset(currentPointerOffset)) {
        reject();
      } else {
        onPointerMove(event);
      }
    }
    if (event is PointerUpEvent) onPointerUp(event);
    if (event is PointerCancelEvent) onPointerCancel(event);
  }

  @override
  void didStopTrackingLastPointer(int pointer) {
    this.dispose();
    onDispose?.call(this);
  }

  void onPointerDown(PointerDownEvent event) {}
  void onPointerMove(PointerMoveEvent event) {}
  void onPointerUp(PointerUpEvent event) {}
  void onPointerCancel(PointerCancelEvent event) => reject();

  void accept() => resolve(GestureDisposition.accepted);
  void reject() => resolve(GestureDisposition.rejected);

  @override
  void acceptGesture(int pointer) {
    super.acceptGesture(pointer);

    // Since the gesture was accepted, call the function below to allow it to be disposed.
    didStopTrackingLastPointer(pointer);
    isAccepted = true;
  }

  @override
  void rejectGesture(int pointer) {
    super.rejectGesture(pointer);

    // Since the gesture was rejected, call the function below to allow it to be disposed.
    didStopTrackingLastPointer(pointer);
  }
}

/// The mixin provides functionality to continuously track the defined
/// pointers to prevent the gesture from being rejected.
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
mixin HoldableGestureRecognizerMixin on OneSequenceGestureRecognizer {
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
}

/// The mixin that adds focus gesture recognition to [OneSequenceGestureRecognizer].
/// Provides callbacks for when a focus gesture starts or ends.
mixin FocusableGestureRecognizerMixin on OneSequenceGestureRecognizer {
  VoidCallback? onFocusStart;
  VoidCallback? onFocusEnd;

  /// The value defines whether the current focus is active.
  bool isFocusActive = false;

  /// Invokes the [onFocusStart] callback when a focus gesture is initiated.
  /// Therefore, this method should be called when consecutive events started.
  void focusStart() {
    assert(isFocusActive == false, "Already focus is enabled.");
    isFocusActive = true;
    onFocusStart?.call();
  }

  /// Invokes the [onFocusEnd] callback when a focus gesture is finished.
  /// Therefore, this method should be called whena consecutive events ended.
  void focusEnd() {
    assert(isFocusActive, "Already focus is not enabled.");
    isFocusActive = false;
    onFocusEnd?.call();
  }

  /// Ensures that focus is deactivated if it is currently active.
  /// This method guarantees that focus will be properly ended in
  /// situations where it remains active.
  void ensureFocusEnd() {
    if (isFocusActive) focusEnd();
  }
}

/// The gesture recognizer that tracks holding gestures, defined as when a pointer
/// is pressed but not yet released. It resolves the gesture if the pointer
/// is lifted.
/// 
/// Primarily used to prevent a tap gesture from being immediately
/// recognized on pointer down when there are no competing gestures.
class HoldingGestureRecognizer extends OneSequenceGestureRecognizer {
  @override
  String get debugDescription => "holding";

  /// Called when the recognizer stops tracking the last pointer.
  /// This method is empty since no specific action is needed when the last pointer is stopped.
  @override
  void didStopTrackingLastPointer(int pointer) {}

  /// Handles the incoming pointer events. If a [PointerUpEvent] is detected,
  /// the gesture is rejected for the acceptance of other gestures. (e.g. tap)
  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerUpEvent) resolve(GestureDisposition.rejected);
  }
}

class TouchRippleTapGestureRecognizer extends TouchRippleGestureRecognizer {
  TouchRippleTapGestureRecognizer({
    required super.context,
    required super.onlyMainButton,
    required this.onTap,
    required this.onTapRejectable,
    required this.onTapReject,
    required this.onTapAccept,
    required this.previewMinDuration,
    required this.acceptableDuration,
  });

  /// The callback function is invoked when a gesture recognizer is ultimately accepted.
  final TouchRippleCallback onTap;
  final TouchRippleCallback onTapRejectable;
  final VoidCallback onTapReject;
  final VoidCallback onTapAccept;
  final Duration previewMinDuration;
  final Duration acceptableDuration;

  Timer? _previewTimer;
  Timer? _rejectsTimer;

  bool isRejectable = false;

  @override
  String get debugLabal => "tap";

  @override
  void onPointerDown(PointerDownEvent event) {
    if (previewMinDuration != Duration.zero) {
      _previewTimer = Timer(previewMinDuration, () {
        isRejectable = true;
        onTapRejectable.call(originOffset);
      });
    }

    if (acceptableDuration != Duration.zero) {
      _rejectsTimer = Timer(acceptableDuration, reject);
    }
  }

  @override
  void acceptGesture(int pointer) {
    super.acceptGesture(pointer);

    if (isRejectable) {
      return onTapAccept.call();
    }

    onTap.call(originOffset);
  }

  @override
  void rejectGesture(int pointer) {
    super.rejectGesture(pointer);

    if (isRejectable) onTapReject.call();
  }

  @override
  void dispose() {
    super.dispose();
    _previewTimer?.cancel();
    _rejectsTimer?.cancel();
  }
}

class TouchRippleDoubleTapGestureRecognizer extends TouchRippleGestureRecognizer
    with HoldableGestureRecognizerMixin,
         FocusableGestureRecognizerMixin {

  TouchRippleDoubleTapGestureRecognizer({
    required super.context,
    required super.onlyMainButton,
    required this.acceptableDuration,
    required this.aliveDuration,
    required this.onDoubleTap,
    required this.onDoubleTapStart,
    required this.onDoubleTapEnd
  });

  @override
  String get debugLabal => "double-tap";

  /// Refer to the doubleTappableDuration value of the [TouchRippleContext] for details.
  final Duration acceptableDuration;
  final Duration aliveDuration;

  final TouchRippleConsecutiveCallback onDoubleTap;
  final VoidCallback? onDoubleTapStart;
  final VoidCallback? onDoubleTapEnd;

  /// The value defines number of taps and updated when a pointer is up.
  int tapCount = 0;

  /// The value defines number of consecutive count for the double-tap event.
  int count = 0;

  Timer? _rejectTimer;
  Timer? _aliveTimer;

  @override
  void focusStart() {
    super.focusStart();
    onDoubleTapStart?.call();
  }

  @override
  void focusEnd() {
    super.focusEnd();
    onDoubleTapEnd?.call();
  }

  @override
  void onPointerDown(PointerDownEvent event) {
    /// Holds the added pointer to prevent the gesture from being automatically
    /// accepted in specific or all situations, even when there are no competitors.
    this.hold();
  }

  @override
  void onPointerUp(PointerUpEvent event) {
    super.onPointerUp(event);

    if (++tapCount >= 2) {
      assert(_rejectTimer != null, "In the correct, double taps cannot occur without the reject timer is not exists.");
      assert(_rejectTimer!.isActive || isFocusActive, "In the correct, double taps cannot occur without the reject timer is active.");
      _rejectTimer?.cancel();

      if (onDoubleTap(originOffset, count++)) {
        // Calls the likecycle callback function that is called when started.
        if (tapCount == 2) {
          focusStart();
        }

        _aliveTimer?.cancel();
        _aliveTimer = Timer(aliveDuration, accept);
        return;
      }

      this.accept();
    } else {
      _rejectTimer ??= Timer(acceptableDuration, reject);
    }
  }

  @override
  void acceptGesture(int pointer) {
    super.acceptGesture(pointer);

    // Calls the likecycle callback function that is called when ended.
    if (isFocusActive && --tapCount == 1) {
      focusEnd();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _rejectTimer?.cancel();
    _aliveTimer?.cancel();
  }
}

class TouchRippleLongTapGestureRecognizer extends TouchRippleGestureRecognizer with FocusableGestureRecognizerMixin {
  TouchRippleLongTapGestureRecognizer({
    required super.context,
    required super.onlyMainButton,
    required this.delayDuration,
    required this.cycleDuration,
    required this.acceptableDuration,
    required this.focusTiming,
    required this.onLongTap,
    required this.onLongTapRejectable,
    required this.onLongTapReject,
    required this.onLongTapAccept,
    required this.onLongTapStart,
    required this.onLongTapEnd,
  });

  @override
  String get debugLabal => "long-tap";

  final Duration delayDuration;
  final Duration cycleDuration;
  final Duration acceptableDuration;
  final TouchRippleFocusTiming focusTiming;

  final TouchRippleContinuableCallback onLongTap;
  final TouchRippleCallback onLongTapRejectable;
  final VoidCallback onLongTapReject;
  final VoidCallback onLongTapAccept;
  final VoidCallback? onLongTapStart;
  final VoidCallback? onLongTapEnd;

  Timer? delayTimer;
  Timer? cycleTimer;
  Timer? acceptTimer;

  /// The value defines number of consecutive count for the long-tap event.
  int count = 0;

  /// the value defines wheter a long-tap current is rejectable effect.
  bool isRejectable = false;

  bool get isConsecutive => count > 0;

  @override
  void onPointerDown(PointerDownEvent event) {
    delayTimer = Timer(delayDuration, () {
      isRejectable = true;
      onLongTapRejectable.call(originOffset);

      if (focusTiming == TouchRippleFocusTiming.rejectable) {
        focusStart();
      }

      assert(acceptTimer == null);
      acceptTimer = Timer(acceptableDuration, accept);
    });
  }

  @override
  void onPointerUp(PointerUpEvent event) {
    if (count == 0) {
      reject();
    } else {
      // Need to call the reject callback function separately only when current is rejectable.
      if (isRejectable) onLongTapReject.call();

      onLongTapEnd?.call();
      cycleTimer?.cancel();
      acceptTimer?.cancel();
      didStopTrackingLastPointer(event.pointer);
      focusEnd();
    }
  }

  void onConsecutive(int pointer) {
    isRejectable = false;
    cycleTimer?.cancel();
    cycleTimer = Timer(cycleDuration, () {
      isRejectable = true;
      onLongTapRejectable.call(originOffset);

      // Perform delayed recursive as async about this consecutive task.
      acceptTimer = Timer(acceptableDuration, () => checkConsecutive(pointer));
    });
  }

  /// Check if the long-tap gesture is currently can be consecutive.
  void checkConsecutive(int pointer) {
    onLongTapAccept.call();
    if (onLongTap.call(count)) {
      // If the [count] is 0, it means the first consecutive cycle, Therefore calls
      // the lifecycle callback function that is called when consecutive gesture started.
      if (count == 0) onLongTapStart?.call();

      count += 1;
      onConsecutive(pointer);
    } else {
      // If the current is consecutive status, Need to separately calls the
      // lifecycle callback function that is called when consecutive gesture ended.
      if (isConsecutive) onLongTapEnd?.call();

      didStopTrackingLastPointer(pointer);
      ensureFocusEnd();
    }
  }

  @override
  void acceptGesture(int pointer) {
    if (focusTiming == TouchRippleFocusTiming.consecutive) {
      focusStart();
    }

    // Need to checks about a consecutive behavior first.
    checkConsecutive(pointer);
  }

  @override
  void rejectGesture(int pointer) {
    super.rejectGesture(pointer);

    if (isRejectable) {
      onLongTapReject.call();

      if (focusTiming == TouchRippleFocusTiming.rejectable) {
        focusEnd();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    delayTimer?.cancel();
    cycleTimer?.cancel();
    acceptTimer?.cancel();
  }
}

class TouchRippleDragGestureRecognizer extends TouchRippleGestureRecognizer {
  TouchRippleDragGestureRecognizer({
    required super.context,
    required super.onlyMainButton,
    required this.axis,
    required this.onDrag,
    required this.onDragStart,
    required this.onDragEnd
  });

  final Axis axis;
  final TouchRippleDragCallback onDrag;
  final TouchRippleCallback? onDragStart;
  final VoidCallback? onDragEnd;

  @override
  String get debugLabal => axis == Axis.horizontal ? "drag-horizontal" : "darg-vertical";

  @override
  void onPointerMove(PointerMoveEvent event) {
    super.onPointerMove(event);

    assert(_pointerDownOffset != null);
    assert(_pointerMoveOffset != null);
    final double delta = axis == Axis.horizontal
      ? _pointerMoveOffset!.dx - _pointerDownOffset!.dx
      : _pointerMoveOffset!.dy - _pointerDownOffset!.dy;

    // Accepts the gesture when the user drags horizontally beyond the touch slop threshold.
    if (delta.abs() >= kTouchSlop && !isAccepted) accept();
    if (isAccepted) {
      onDrag.call(delta);
    }
  }

  @override
  void onPointerUp(PointerUpEvent event) {
    if (isAccepted) {
      didStopTrackingLastPointer(event.pointer);
      onDragEnd?.call();
    } else {
      reject();
    }
  }

  @override
  void acceptGesture(int pointer) {
    isAccepted = true;
    onDragStart?.call(currentPointerOffset);
  }
}