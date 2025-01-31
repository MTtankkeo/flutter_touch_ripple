import 'package:flutter/cupertino.dart';

/// This widget declared to handle and prevent gesture propagation  
/// to parent widgets when a child widget triggers a gesture  
/// using the [Listener] widget.  
class TouchRipplePointerListener extends StatefulWidget {
  const TouchRipplePointerListener({
    super.key,
    required this.child,
    this.onPointerDown,
    this.onPointerMove,
    this.onPointerUp,
    this.onPointerCancel,
    this.behavior = HitTestBehavior.deferToChild,
  });

  final Widget child;
  final HitTestBehavior behavior;

  final PointerDownEventListener? onPointerDown;
  final PointerMoveEventListener? onPointerMove;
  final PointerUpEventListener? onPointerUp;
  final PointerCancelEventListener? onPointerCancel;

  static State<TouchRipplePointerListener>? of(BuildContext context) {
    return context.findAncestorStateOfType<TouchRipplePointerListenerState>();
  }

  @override
  State<TouchRipplePointerListener> createState() => TouchRipplePointerListenerState();
}

class TouchRipplePointerListenerState extends State<TouchRipplePointerListener> {
  /// Indicates whether all events are canceled or  
  /// event-related functions cannot be invoked.  
  ///  
  /// - Declared to cancel the trigger of a parent widget when
  ///   a child widget is triggered and a [TouchRippleListener]
  ///   exists as its descendant.  
  bool isCanceled = false;

  /// Handles the pointer events and define multiple actions.
  void _handlePointer(PointerEvent event) {
    if(event is PointerDownEvent) {
      // Notify to ancestor widget to listener cancelling.
      (TouchRipplePointerListener.of(context) as TouchRipplePointerListenerState?)?..cancel();

      if(!isCanceled) widget.onPointerDown?.call(event);
    } else if(event is PointerMoveEvent) {
      if(isCanceled) return;

      widget.onPointerMove?.call(event);
    } else { // as PointerUpEvent, PointerCancelEvent
      if(isCanceled) { isCanceled = false; return; }
      
        event is PointerUpEvent
      ? widget.onPointerUp?.call(event)
      : widget.onPointerCancel?.call(event as PointerCancelEvent);
    }
  }

  /// Cancels the current pointer events for the nested gestures.
  void cancel() => isCanceled = true;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: widget.behavior,
      onPointerDown: (event) => _handlePointer(event),
      onPointerMove: (event) => _handlePointer(event),
      onPointerUp: (event) => _handlePointer(event),
      child: widget.child,
    );
  }
}