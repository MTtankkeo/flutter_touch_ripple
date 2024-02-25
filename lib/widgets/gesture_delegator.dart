/*
import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:flutter_touch_ripple/widgets/components/descendant_stateful_widget_visitable.dart';






class TouchRippleGestureDelegator extends TouchRipple {
  const TouchRippleGestureDelegator({
    super.key,
    required super.child,
  }) : useIndependentBehaviors = false;

  // 독립적인 동작들을 정의합니다.
  const TouchRippleGestureDelegator.independent({
    super.key,
    required super.child,
    super.onTap,
    super.onDoubleTap,
    super.onDoubleTapStart,
    super.onDoubleTapEnd,
    super.onLongTap,
    super.onLongTapStart,
    super.onLongTapEnd,
  }) : useIndependentBehaviors = true;

  final bool useIndependentBehaviors;

  @override
  State<TouchRippleGestureDelegator> createState() => _TouchRippleGestureDelegatorState();
}

class _TouchRippleGestureDelegatorState extends State<TouchRippleGestureDelegator>
      with DescendantStatefulWidgetVisitableMixin<TouchRippleGestureDelegator, TouchRipple> {

  @override
  void afterInitialDescendantVisited((TouchRipple, State<TouchRipple>)? visitedDescendant) {
    setState(() {
      // References child widgets and updates their state to modify
      // the current widget tree.
    });
  }

  @override
  Widget build(BuildContext context) {
    if(super.visitedDescendant != null) {
      final child = super.visitedDescendant!.$1;
      final state = super.visitedDescendant!.$2 as TouchRippleWidgetState;

      if (widget.useIndependentBehaviors) {
        return state.createGestureDetector(
          onTap: widget.onTap,
          onDoubleTap: widget.onDoubleTap,
          onDoubleTapStart: widget.onDoubleTapStart,
          onDoubleTapEnd: widget.onDoubleTapEnd,
          onLongTap: widget.onLongTap,
          onLongTapStart: widget.onLongTapStart,
          onLongTapEnd: widget.onLongTapEnd,
          onFocusStart: widget.onFocusStart,
          onFocusEnd: widget.onFocusEnd,
          child: widget.child,
        );
      }

      return state.createGestureDetector(
        onTap: child.onTap,
        onDoubleTap: child.onDoubleTap,
        onDoubleTapStart: child.onDoubleTapStart,
        onDoubleTapEnd: child.onDoubleTapEnd,
        onLongTap: child.onLongTap,
        onLongTapStart: child.onLongTapStart,
        onLongTapEnd: child.onLongTapEnd,
        onFocusStart: child.onFocusStart,
        onFocusEnd: child.onFocusEnd,
        child: widget.child,
      );
    }
    
    return widget.child;
  }
}
*/
