import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_context.dart';

/// Signature for the callback function that is called when a [GestureRecognizer] disposed.
typedef GestureRecognizerDisposeCallback = void Function(GestureRecognizer instance);

/// The abstract class that defines the touch ripple gesture base behavior,
/// which is a basic and essential behavior.
abstract class TouchRippleGestureRecognizer extends OneSequenceGestureRecognizer {
  TouchRippleGestureRecognizer({
    required this.context,
    required this.rejectBehavior,
  });

  final BuildContext context;

  final TouchRippleRejectBehavior rejectBehavior;

  GestureRecognizerDisposeCallback? onDispose;

  @override
  String get debugDescription => 'Touch Ripple Event CallBack: $debugLabal';

  String get debugLabal;

  /// The pointer position when the pointer was first detected is defined.
  Offset? _pointerDownOffset;

  /// The updated pointer position since the pointer went down is defined.
  Offset? _pointerMoveOffset;

  /// Returns the current referenceable pointer offset.
  Offset get currentPointerOffset => _pointerMoveOffset ?? (_pointerDownOffset ?? Offset.zero);

  /// Returns the distance the pointer has moved since it was detected.
  Offset get pointerMoveDistance =>
      (_pointerDownOffset ?? Offset.zero) - (_pointerMoveOffset ?? Offset.zero);

  /// Returns the render box corresponding to the initialized build context.
  RenderBox get _renderBox => context.findRenderObject() as RenderBox;

  /// Returns whether to reject the gesture based on the given pointer offset.
  bool rejectByOffset(Offset offset) {
    if (rejectBehavior == TouchRippleRejectBehavior.none) return false;
    if (rejectBehavior == TouchRippleRejectBehavior.leave) {
      final isPointerHit = _renderBox.hitTest(BoxHitTestResult(), position: offset);
      return !isPointerHit;
    }

    // is TouchRippleCancalBehavior.touchSlop
    return pointerMoveDistance.dx.abs() > kTouchSlop || pointerMoveDistance.dy.abs() > kTouchSlop;
  }

  /// Defines the values needed to process the gesture and
  /// calls the callback function corresponding to the given event.
  ///
  /// Will reject the gesture on its own,
  /// constantly referencing whether it must be rejected when pointer moved.
  @override
  void handleEvent(PointerEvent event) {
    final localPosition = _renderBox.globalToLocal(event.position);

    if (event is PointerDownEvent) {
      _pointerDownOffset = localPosition;
    }

    // Is current pointer move event
    _pointerMoveOffset = localPosition;

    /// Calls the callback function corresponding to the given event.
    if (event is PointerDownEvent) onPointerDown(event);
    if (event is PointerMoveEvent) {
      final isRejectable = rejectByOffset(currentPointerOffset);
      isRejectable ? reject() : onPointerMove(event);
    }
    if (event is PointerUpEvent) onPointerUp(event);
    if (event is PointerCancelEvent) onPointerCancel(event);
  }

  @override
  void didStopTrackingLastPointer(int pointer) {
    onDispose?.call(this);
  }

  void onPointerDown(PointerDownEvent event) {}
  void onPointerMove(PointerMoveEvent event) {}
  void onPointerUp(PointerUpEvent event) {}
  void onPointerCancel(PointerCancelEvent event) => reject();

  void accept() => resolve(GestureDisposition.accepted);
  void reject() => resolve(GestureDisposition.rejected);
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

class HoldingGestureRecognizer extends OneSequenceGestureRecognizer {
  @override
  String get debugDescription => "Holding";

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerUpEvent) resolve(GestureDisposition.rejected);
  }
}

class TouchRippleTapGestureRecognizer extends TouchRippleGestureRecognizer {
  TouchRippleTapGestureRecognizer({
    required super.context,
    required super.rejectBehavior,
    required this.onTap,
    required this.onTapRejectable,
    required this.onTapReject,
    required this.onTapAccept
  });

  /// The callback function is invoked when a gesture recognizer is ultimately accepted.
  final VoidCallback onTap;
  final VoidCallback onTapRejectable;
  final VoidCallback onTapReject;
  final VoidCallback onTapAccept;

  @override
  String get debugLabal => "Touch Ripple Tap";

  @override
  void acceptGesture(int pointer) {
    super.acceptGesture(pointer);

    onTap.call();
  }

  @override
  void rejectGesture(int pointer) {
    super.rejectGesture(pointer);

    print("reject");
  }
}
