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
    this.onLongTap,
    this.behavior,
    this.rippleColor,
    this.hoverColor,
    this.rippleScale,
    this.rippleBlurRadius,
    this.rippleBorderRadius,
    this.rejectBehavior,
    this.overlapBehavior,
    this.renderOrderType,
    this.controller,
    required this.child,
  }) : assert(rippleScale == null || rippleScale != 0);

  /// The callback function is called when the user taps or clicks.
  final VoidCallback? onTap;

  /// The callback function is called when the user double taps or double clicks.
  final TouchRippleContinuableCallback? onDoubleTap;

  /// The callback function is called when the user long presses or long clicks.
  final TouchRippleContinuableCallback? onLongTap;

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

  /// The behavior that defines when a gesture should be rejected,
  /// specifying the conditions for rejection.
  final TouchRippleRejectBehavior? rejectBehavior;

  /// The behavior of a touch ripple when it overlaps with other
  /// ripple effects. (e.g. overlappable, cancel, ignore)
  final TouchRippleOverlapBehavior? overlapBehavior;

  /// The enumeration specifies the rendering order of the touch ripple effect,
  /// determining whether it should appear in the foreground or background.
  final TouchRippleRenderOrderType? renderOrderType;

  final TouchRippleController? controller;

  final Widget child;

  @override
  State<TouchRipple> createState() => _TouchRippleState();
}

class _TouchRippleState extends State<TouchRipple> with TouchRippleContext, TickerProviderStateMixin {
  late TouchRippleController _controller = widget.controller ?? TouchRippleController();

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
      onLongTap: widget.onLongTap,
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
  Duration get previewDuration => Duration(milliseconds: 100);

  @override
  Duration get tappableDuration => Duration.zero;

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
    );
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