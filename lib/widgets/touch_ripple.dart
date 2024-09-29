import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_animation.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple_render.dart';

/// This widget, inspired by Google Material's ripple effect, visualizes
/// various gestures such as tap, double tap, and long press through
/// ripple effects.
class TouchRipple<T extends dynamic> extends StatefulWidget {
  const TouchRipple({
    super.key,
    this.onTap,
    this.onTapAsync,
    this.onTapAsyncStart,
    this.onTapAsyncEnd,
    this.onDoubleTap,
    this.onDoubleTapConsecutive,
    this.onDoubleTapStart,
    this.onDoubleTapEnd,
    this.onLongTap,
    this.onLongTapStart,
    this.onLongTapEnd,
    this.onFocusStart,
    this.onFocusEnd,
    this.onHoverStart,
    this.onHoverEnd,
    this.behavior,
    this.rippleColor,
    this.hoverColor,
    this.focusColor,
    this.rippleScale,
    this.rippleBlurRadius,
    this.rippleBorderRadius,
    this.previewDuration,
    this.tappableDuration,
    this.doubleTappableDuration,
    this.doubleTapAliveDuration,
    this.longTappableDuration,
    this.longTapCycleDuration,
    this.tapBehavior,
    this.doubleTapBehavior,
    this.longTapBehavior,
    this.rejectBehavior,
    this.overlapBehavior,
    this.renderOrderType,
    this.focusTiming,
    this.hoverAnimation,
    this.focusAnimation,
    this.useHoverEffect,
    this.useFocusEffect,
    this.onlyMainButton,
    this.controller,
    required this.child
  }) : assert(rippleScale == null || rippleScale != 0);

  /// The callback function is called when the user taps or clicks.
  final VoidCallback? onTap;

  /// The callback function is called when the user taps or clicks. but this function
  /// ensures that the touch ripple effect remains visible until the asynchronous
  /// operation is completed and prevents additional events during that time.
  final TouchRippleAsyncCallback<T>? onTapAsync;

  /// The callback function is called when an asynchronous operation is initiated by
  /// a tap. It provides the associated Future instance for the ongoing operation.
  final TouchRippleAsyncNotifyCallback<T>? onTapAsyncStart;

  /// The callback function is called when the result of the asynchronous operation
  /// is ready. It allows handling the result once the operation is complete.
  final TouchRippleAsyncResultCallback<T>? onTapAsyncEnd;

  /// The callback function is called when the user double taps or double clicks.
  final VoidCallback? onDoubleTap;

  /// The callback function is called to determine whether consecutive double taps
  /// should continue. It returns a [bool] indicating whether the long tap event
  /// should continue after the initial occurrence.
  final TouchRippleContinuableCallback? onDoubleTapConsecutive;

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

  /// The callback function is a lifecycle callback for focus touch ripple events.
  /// It is called when a focus touch event starts, allowing for the initiation
  /// of actions based on the beginning of the focus event sequence.
  final VoidCallback? onFocusStart;

  /// The callback function is a lifecycle callback for focus touch ripple events.
  /// It is called when a focus touch event ends, providing the advantage of
  /// knowing when a series of focus touch ripple events has concluded.
  final VoidCallback? onFocusEnd;

  /// The callback function called when the cursor begins hovering over the widget. (by [MouseRegion])
  /// This function allows for the initiation of actions based on the hover interaction.
  /// This function is not called in touch-based environments yet.
  final VoidCallback? onHoverStart;

  /// The callback function called when the cursor begins to leave the widget. (by [MouseRegion])
  /// This function allows for actions to be executed based on the end of the hover interaction.
  /// This function is not called in touch-based environments yet.
  final VoidCallback? onHoverEnd;

  /// The behavior of hit testing for the child widget.
  final HitTestBehavior? behavior;

  /// The background color of a spread ripple effect.
  final Color? rippleColor;

  /// The background color of a effect when the user hovers.
  final Color? hoverColor;

  /// The background color of the solid effect when a consecutive
  /// (e.g. about double-tap and long-tap) event state occurs.
  final Color? focusColor;

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
  final Duration? doubleTapAliveDuration;

  /// The minimum duration used to distinguish between a tap and a long-tap.
  /// After this duration has passed, the long-tap effect starts to be
  /// displayed to the user.
  final Duration? longTappableDuration;

  /// The duration until long-tap reactivation. After this period, any pointer down
  /// and move is still considered a long-tap without requiring the continuous
  /// process of pointer-up followed by pointer-down.
  final Duration? longTapCycleDuration;

  /// The touch ripple behavior applied to the touch ripple effect
  /// for tapped or clicked.
  final TouchRippleBehavior? tapBehavior;

  /// The touch ripple behavior applied to the touch ripple effect
  /// for double tapped or double clicked.
  final TouchRippleBehavior? doubleTapBehavior;

  /// The touch ripple behavior applied to the touch ripple effect
  /// for long tapped or long pressed and long clicked.
  final TouchRippleBehavior? longTapBehavior;

  /// The behavior that defines when a gesture should be rejected,
  /// specifying the conditions for rejection.
  final TouchRippleRejectBehavior? rejectBehavior;

  /// The behavior of a touch ripple when it overlaps with other
  /// ripple effects. (e.g. overlappable, cancel, ignore)
  final TouchRippleOverlapBehavior? overlapBehavior;

  /// The enumeration specifies the rendering order of the touch ripple effect,
  /// determining whether it should appear in the foreground or background.
  final TouchRippleRenderOrderType? renderOrderType;

  /// The enumeration defines when the focus of a touch ripple should start,
  /// specifying the priority based on timing conditions.
  final TouchRippleFocusTiming? focusTiming;

  /// The instance of the fade animation for the touch ripple effect
  /// when the hover effect is triggered.
  final TouchRippleAnimation? hoverAnimation;

  /// The instance of the fade animation for the touch ripple effect
  /// when the focus effect is triggered.
  final TouchRippleAnimation? focusAnimation;

  /// The boolean that is whether only the main button is recognized as a gesture
  /// when the user that is using mouse device clicks on the widget.
  final bool? onlyMainButton;

  /// Whether the hover effect is enabled for touch ripple animations.
  /// If true, a solid hover effect is applied when the user hovers.
  final bool? useHoverEffect;

  /// Whether the focus effect is enabled for touch ripple animations.
  /// If true, a solid focus color effect is applied for consecutive
  /// events like double-tap and long-tap or others.
  final bool? useFocusEffect;

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
      onDoubleTapConsecutive: widget.onDoubleTapConsecutive,
      onDoubleTapStart: widget.onDoubleTapStart,
      onDoubleTapEnd: widget.onDoubleTapEnd,
      onLongTap: widget.onLongTap,
      onLongTapStart: widget.onLongTapStart,
      onLongTapEnd: widget.onLongTapEnd,
      onFocusStart: widget.onFocusStart,
      onFocusEnd: widget.onFocusEnd,
      onHoverStart: widget.onHoverStart,
      onHoverEnd: widget.onHoverEnd,
      onlyMainButton: widget.onlyMainButton ?? style?.onlyMainButton,
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
    return widget.rippleColor // 1 priority
        ?? style?.rippleColor // 2 priority
        ?? const Color.fromRGBO(0, 0, 0, 0.2);
  }

  @override
  Color get hoverColor {
    return widget.hoverColor // 1 priority
        ?? style?.hoverColor // 2 priortiy
        ?? TouchRippleColor.withAlphaOf(rippleColor, 0.5);
  }

  @override
  Color get focusColor {
    return widget.focusColor // 1 priority
        ?? style?.focusColor // 2 priority
        ?? TouchRippleColor.withAlphaOf(rippleColor, 0.5);
  }

  @override
  double get rippleScale {
    return widget.rippleScale // 1 priority
        ?? style?.rippleScale // 2 priority
        ?? 1;
  }

  @override
  double get rippleBlurRadius {
    return widget.rippleBlurRadius // 1 priority
        ?? style?.rippleBlurRadius // 2 priority
        ?? 0;
  }

  @override
  BorderRadius get rippleBorderRadius {
    return widget.rippleBorderRadius // 1 priority
        ?? style?.rippleBorderRadius // 2 priority
        ?? BorderRadius.zero;
  }

  @override
  Duration get previewDuration {
    return widget.previewDuration // 1 priority
        ?? style?.previewDuration // 2 priority
        ?? Duration(milliseconds: 100);
  }

  @override
  Duration get tappableDuration {
    return widget.tappableDuration // 1 priority
        ?? style?.tappableDuration // 2 priority
        ?? Duration.zero;
  }

  @override
  Duration get doubleTappableDuration {
    return widget.doubleTappableDuration // 1 priority
        ?? style?.doubleTappableDuration // 2 priority
        ?? Duration(milliseconds: 200);
  }

  @override
  Duration get doubleTapAliveDuration {
    return widget.doubleTapAliveDuration // 1 priority
        ?? style?.doubleTapAliveDuration // 2 priority
        ?? Duration(milliseconds: 1000);
  }

  @override
  Duration get longTappableDuration {
    return widget.longTappableDuration // 1 priority
        ?? style?.longTappableDuration // 2 priority
        ?? Duration(milliseconds: 200);
  }

  @override
  Duration get longTapCycleDuration {
    return widget.longTapCycleDuration // 1 priority
        ?? style?.longTapCycleDuration // 2 priority
        ?? Duration(milliseconds: 500);
  }

  @override
  TouchRippleBehavior get tapBehavior {
    return const TouchRippleBehavior( // default
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
    )
    .merge(style?.tapBehavior)  // 2 priority
    .merge(widget.tapBehavior); // 1 priority
  }

  @override
  TouchRippleBehavior get doubleTapBehavior {
    return tapBehavior
      .merge(style?.doubleTapBehavior)
      .merge(widget.doubleTapBehavior);
  }

  @override
  TouchRippleBehavior get longTapBehavior {
    return tapBehavior
      .merge(const TouchRippleBehavior( // default
        lowerPercent: 0,
        upperPercent: 1,
        spreadDuration: Duration(milliseconds: 1000),
        spreadCurve: Curves.linear,
        fadeInDuration: Duration(milliseconds: 500),
      ))
      .merge(style?.longTapBehavior)  // 2 priority
      .merge(widget.longTapBehavior); // 1 priority
  }

  @override
  TouchRippleRejectBehavior get rejectBehavior {
    return widget.rejectBehavior // 1 priority
        ?? style?.rejectBehavior // 2 priority
        ?? TouchRippleRejectBehavior.leave;
  }

  @override
  TouchRippleOverlapBehavior get overlapBehavior {
    return widget.overlapBehavior // 1 priority
        ?? style?.overlapBehavior // 2 priority
        ?? TouchRippleOverlapBehavior.overlappable;
  }

  @override
  TouchRippleAnimation get hoverAnimation {
    return TouchRippleAnimation(
      fadeInDuration: Duration(milliseconds: 150),
      fadeInCurve: Curves.easeOut,
      fadeOutDuration: Duration(milliseconds: 150),
      fadeOutCurve: Curves.easeIn
    )
    .merge(style?.hoverAnimation)
    .merge(widget.hoverAnimation);
  }

  @override
  TouchRippleAnimation get focusAnimation {
    return TouchRippleAnimation(
      fadeInDuration: Duration(milliseconds: 300),
      fadeInCurve: Curves.easeOut,
      fadeOutDuration: Duration(milliseconds: 300),
      fadeOutCurve: Curves.easeIn
    )
    .merge(style?.focusAnimation)
    .merge(widget.focusAnimation);
  }

  @override
  TouchRippleFocusTiming get focusTiming {
    return widget.focusTiming
        ?? style?.focusTiming
        ?? TouchRippleFocusTiming.rejectable;
  }

  @override
  bool get useHoverEffect {
    return widget.useHoverEffect // 1 priority
        ?? style?.useHoverEffect // 2 priority
        ?? true;
  }

  @override
  bool get useFocusEffect {
    return widget.useFocusEffect // 1 priority
        ?? style?.useFocusEffect // 2 priority
        ?? true;
  }
}