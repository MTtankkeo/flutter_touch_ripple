import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/behavior.dart';
import 'package:flutter_touch_ripple/components/gestures/recognizers.dart';






/// An abstract class that defines the touch ripple gesture base behavior,
/// which is a basic and essential behavior.
abstract class BaseTouchRippleGestureRecognizer extends ResetableGestureRecognizer {
  BaseTouchRippleGestureRecognizer({
    required this.context,
    required this.cancelBehavior,
  });
  
  final BuildContext context;
  final TouchRippleRejectBehavior cancelBehavior;

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
  Offset get pointerMoveDistance => (_pointerDownOffset ?? Offset.zero) - (_pointerMoveOffset ?? Offset.zero);

  /// Returns the render box corresponding to the initialized build context.
  RenderBox get _renderBox => context.findRenderObject() as RenderBox;
  
  /// Returns whether to reject the gesture based on the given pointer offset.
  bool rejectByOffset(Offset offset) {
    if (cancelBehavior == TouchRippleRejectBehavior.leave) {
      final isPointerHit = _renderBox.hitTest(
        BoxHitTestResult(),
        position: offset,
      );
      return !isPointerHit;
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
  
  void onPointerDown(PointerDownEvent event) {}
  void onPointerMove(PointerMoveEvent event) {}
  void onPointerUp(PointerUpEvent event) {}
  void onPointerCancel(PointerCancelEvent event) => reject();

  @override
  void reset() {
    _pointerDownOffset = null;
    _pointerMoveOffset = null;
  }
  
  void accept() => resolve(GestureDisposition.accepted);
  void reject() => resolve(GestureDisposition.rejected);
}