import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple_render.dart';

/// This widget, inspired by Google Material's ripple effect, visualizes
/// various gestures such as tap, double tap, and long press through
/// ripple effects.
class TouchRipple extends StatefulWidget {
  const TouchRipple({
    super.key,
    this.onTap,
    this.onDoubleTap,
    this.onDoubleTapStart,
    this.onDoubleTapEnd,
    this.onLongTap,
    this.onLongTapStart,
    this.onLongTapEnd,
    this.onConsecutive,
    this.onConsecutiveStart,
    this.onConsecutiveEnd,
    this.behavior,
    this.rippleColor,
    this.hoverColor,
    this.rippleScale,
    this.rippleBlurRadius,
    this.rippleBorderRadius,
    this.previewDuration,
    this.tappableDuration,
    this.doubleTappableDuration,
    this.doubleTapAliveDuration,
    this.tapBehavior,
    this.rejectBehavior,
    this.overlapBehavior,
    this.renderOrderType,
    this.onlyMainButton,
    this.controller,
    required this.child
  }) : assert(rippleScale == null || rippleScale != 0);

  /// The callback function is called when the user taps or clicks.
  final VoidCallback? onTap;

  /// The callback function is called when the user double taps or double clicks.
  final TouchRippleContinuableCallback? onDoubleTap;

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

  /// The callback function is called to indicate the occurrence of consecutive
  /// touch ripple events. See Also, this function does not determine 
  /// whether the event should continue rather, it serves to inform 
  /// that a series of consecutive events has taken place.
  final TouchRippleConsecutiveCallback? onConsecutive;

  /// The callback function is a lifecycle callback for consecutive touch 
  /// ripple events. It is called when a consecutive touch event starts, 
  /// allowing for the initiation of actions based on the beginning of 
  /// the consecutive event sequence.
  final VoidCallback? onConsecutiveStart;

  /// The callback function is a lifecycle callback for consecutive touch 
  /// ripple events. It is called when a consecutive touch event ends, 
  /// providing the advantage of knowing when a series of consecutive 
  /// touch ripple events has concluded.
  final VoidCallback? onConsecutiveEnd;

  /// The behavior of hit testing for the child widget.
  final HitTestBehavior? behavior;

  /// The background color of a spread ripple effect.
  final Color? rippleColor;

  /// The background color of a effect when the user hovers.
  final Color? hoverColor;

  /// The scale percentage value of a ripple effect.
  final double? rippleScale;

  /// The radius pixels of a blur filter to touch ripple.
  final double? rippleBlurRadius;

  /// The instance of a border radius for a ripple effect.
  final BorderRadius? rippleBorderRadius;

  /// The duration for which the ripple effect is previewed even
  /// if the gesture is not finalized, allowing the user to see
  /// the effect while the pointer is down or moving.
  final Duration? previewDuration;

  /// The duration after which the gesture is considered rejected
  /// if the pointer is still down and no tap is completed.
  /// If this duration elapses without a successful gesture,
  /// the gesture will be rejected.
  final Duration? tappableDuration;

  /// The minimum duration used to distinguish between a tap and a double-tap.
  /// If the user does not perform a second tap within this duration,
  /// it is considered just a single-tap.
  final Duration? doubleTappableDuration;

  /// The duration until double-tap deactivation. During this period,
  /// any single tap is still considered a double-tap without requiring
  /// continuous double-tapping.
  /// 
  /// See Also, If the callback returns false, the duration will not be utilized,
  final Duration? doubleTapAliveDuration;

  /// The behavior applied to the touch ripple effect when tapped.
  final TouchRippleBehavior? tapBehavior;

  /// The behavior that defines when a gesture should be rejected,
  /// specifying the conditions for rejection.
  final TouchRippleRejectBehavior? rejectBehavior;

  /// The behavior of a touch ripple when it overlaps with other
  /// ripple effects. (e.g. overlappable, cancel, ignore)
  final TouchRippleOverlapBehavior? overlapBehavior;

  /// The enumeration specifies the rendering order of the touch ripple effect,
  /// determining whether it should appear in the foreground or background.
  final TouchRippleRenderOrderType? renderOrderType;

  /// The boolean that is whether only the main button is recognized as a gesture
  /// when the user that is using mouse device clicks on the widget.
  final bool? onlyMainButton;

  final TouchRippleController? controller;

  final Widget child;

  @override
  State<TouchRipple> createState() => _TouchRippleState();
}

class _TouchRippleState extends State<TouchRipple> with TouchRippleContext, TickerProviderStateMixin {
  /// The value defines a unique instance of [TouchRippleController]
  /// to manage the state of the touch ripple in this widget.
  late TouchRippleController _controller = widget.controller ?? TouchRippleController();

  /// Returns the instance of [TouchRippleStyle] inherited widget,
  /// and if it does not exist, returns null.
  TouchRippleStyle? get style => TouchRippleStyle.maybeOf(context);

  @override
  void initState() {
    super.initState();
    _controller.context = this;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TouchRipple oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != null && oldWidget.controller != widget.controller) {
      _controller = widget.controller!..delegateFrom(_controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _renderOrderType =
         widget.renderOrderType // 1
      ?? style?.renderOrderType // 2
      ?? TouchRippleRenderOrderType.background;

    return TouchRippleGestureDetector(
      onTap: widget.onTap,
      onDoubleTap: widget.onDoubleTap,
      onDoubleTapStart: widget.onDoubleTapStart,
      onDoubleTapEnd: widget.onDoubleTapEnd,
      onLongTap: widget.onLongTap,
      onLongTapStart: widget.onLongTapStart,
      onLongTapEnd: widget.onLongTapEnd,
      onConsecutive: widget.onConsecutive,
      onConsecutiveStart: widget.onConsecutiveStart,
      onConsecutiveEnd: widget.onConsecutiveEnd,
      onlyMainButton: widget.onlyMainButton,
      behavior: widget.behavior ?? HitTestBehavior.translucent,
      controller: _controller,
      child: TouchRippleRender(
        controller: _controller,
        orderType: _renderOrderType,
        child: widget.child
      ),
    );
  }

  @override
  TickerProvider get vsync => this;

  @override
  Color get rippleColor {
    return widget.rippleColor ?? style?.rippleColor ?? const Color.fromRGBO(0, 0, 0, 0.2);
  }

  @override
  Color get hoverColor {
    return widget.hoverColor ?? style?.hoverColor ?? const Color.fromRGBO(0, 0, 0, 0.1);
  }

  @override
  double get rippleScale {
    return widget.rippleScale ?? style?.rippleScale ?? 1;
  }

  @override
  double get rippleBlurRadius {
    return widget.rippleBlurRadius ?? style?.rippleBlurRadius ?? 0;
  }

  @override
  BorderRadius get rippleBorderRadius {
    return widget.rippleBorderRadius ?? style?.rippleBorderRadius ?? BorderRadius.zero;
  }

  @override
  Duration get previewDuration {
    return widget.previewDuration ?? style?.previewDuration ?? Duration(milliseconds: 100);
  }

  @override
  Duration get tappableDuration {
    return widget.tappableDuration ?? style?.tappableDuration ?? Duration.zero;
  }

  @override
  Duration get doubleTappableDuration {
    return widget.doubleTappableDuration ?? style?.doubleTappableDuration ?? Duration(milliseconds: 300);
  }

  @override
  Duration get doubleTapAliveDuration {
    return widget.doubleTapAliveDuration ?? style?.doubleTapAliveDuration ?? Duration(milliseconds: 500);
  }

  @override
  TouchRippleBehavior get tapBehavior {
    return TouchRippleBehavior(
      lowerPercent: 0.3,
      upperPercent: 1,
      spreadDuration: Duration(milliseconds: 300),
      spreadCurve: Curves.ease,
      fadeInDuration: Duration(milliseconds: 100),
      fadeInCurve: Curves.ease,
      fadeOutDuration: Duration(milliseconds: 200),
      fadeOutCurve: Curves.ease,
      cancelDuration: Duration.zero,
      cancelCurve: Curves.linear,
      fadeLowerPercent: 0,
      fadeUpperPercent: 1,
      eventCallBackableMinPercent: 0,
      onlyMainButton: true
    ) // default
    .merge(style?.tapBehavior)
    .merge(widget.tapBehavior);
  }

  @override
  TouchRippleRejectBehavior get rejectBehavior {
    return widget.rejectBehavior ?? style?.rejectBehavior ?? TouchRippleRejectBehavior.leave;
  }

  @override
  TouchRippleOverlapBehavior get overlapBehavior {
    return widget.overlapBehavior ?? style?.overlapBehavior ?? TouchRippleOverlapBehavior.overlappable;
  }
}