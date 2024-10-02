import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_animation.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple_render.dart';

/// ### Introduction
/// This widget, inspired by Google Material's ripple effect, visualizes
/// various gestures such as tap(and async), double tap, and long press through
/// ripple effects.
/// 
/// please refer to [GitHub](https://github.com/MTtankkeo/flutter_touch_ripple)
/// when you want to know more about it.
/// 
/// ### How to apply ripple effect?
/// ```dart
/// TouchRipple(
///   // Called when the user taps or clicks.
///   onTap: () => print("Hello, World!"),
///   child: ... // <- this your widget
/// ),
/// ```
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
    this.hitBehavior,
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
    this.cancelBehavior,
    this.overlapBehavior,
    this.renderOrderType,
    this.focusTiming,
    this.origin,
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
  final HitTestBehavior? hitBehavior;

  /// The background color of a spread ripple effect.
  final Color? rippleColor;

  /// The background color of a effect when the user hovers.
  final Color? hoverColor;

  /// The background color of the solid effect when a consecutive
  /// (e.g. about double-tap and long-tap) event state occurs.
  final Color? focusColor;

  /// The scale percentage value of a ripple effect and by default
  /// the origin position is center.
  final double? rippleScale;

  /// The radius pixels of a blur filter for spread ripple effect. It cannot be negative
  /// and as the value increases, the edge of the spread ripple effect becomes blurrier.
  final double? rippleBlurRadius;

  /// The instance of a border radius for a ripple effect. For reference, this option
  /// can be replaced with a widget like [ClipRRect] depending on the situation.
  final BorderRadius? rippleBorderRadius;

  /// The duration for which the ripple effect is previewed even if the gesture is not
  /// finalized, allowing the user to see the effect while the pointer is down or moving.
  final Duration? previewDuration;

  /// The duration after which the gesture is considered rejected if the pointer
  /// is still down and no tap is completed. If this duration elapses without
  /// a successful gesture, the gesture will be rejected.
  final Duration? tappableDuration;

  /// The minimum duration used to distinguish between a tap and a double-tap.
  /// If the user does not perform a second tap within this duration,
  /// it is considered just a single-tap.
  final Duration? doubleTappableDuration;

  /// The duration until double-tap deactivation. During this period, any
  /// single tap is still considered a double-tap without requiring
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

  /// The behavior that defines the touch ripple spread animation
  /// when the touch ripple effect is canceled.
  final TouchRippleCancelBehavior? cancelBehavior;

  /// The behavior of a touch ripple when it overlaps with other
  /// ripple effects. (e.g. overlappable, cancel, ignore)
  final TouchRippleOverlapBehavior? overlapBehavior;

  /// The enumeration specifies the rendering order of the touch ripple effect,
  /// determining whether it should appear in the foreground or background.
  final TouchRippleRenderOrderType? renderOrderType;

  /// The enumeration defines when the focus of a touch ripple should start,
  /// specifying the priority based on timing conditions.
  final TouchRippleFocusTiming? focusTiming;

  /// The enumeration defines the starting point of a spread ripple effect,
  /// specifying the origin of the ripple based on the user interaction.
  final TouchRippleOrigin? origin;

  /// The instance of the fade animation for the touch ripple effect
  /// when the hover effect is triggered.
  final TouchRippleAnimation? hoverAnimation;

  /// The instance of the fade animation for the touch ripple effect
  /// when the focus effect is triggered.
  final TouchRippleAnimation? focusAnimation;

  /// The boolean that is whether only the main button is recognized as
  /// a gesture when the user that is using mouse device clicks on the widget.
  final bool? onlyMainButton;

  /// Whether the hover effect is enabled for touch ripple animations.
  /// If true, a solid hover effect is applied when the user hovers.
  final bool? useHoverEffect;

  /// Whether the focus effect is enabled for touch ripple animations.
  /// If true, a solid focus color effect is applied for consecutive
  /// events like double-tap and long-tap or others.
  final bool? useFocusEffect;

  /// The controller defines and manages states, listeners, a context and
  /// other values related to touch ripple, ensuring that each state
  /// exists uniquely within the controller.
  final TouchRippleController? controller;

  /// The widget that is target to apply touch ripple related effects.
  final Widget child;

  @override
  State<TouchRipple> createState() => _TouchRippleState<T>();
}

/// The widget state implements [TouchRippleContext], allowing it to merge various option
/// in priority order to provide the appropriate style, behavior, and information necessary
/// for rendering the touch ripple effect.
class _TouchRippleState<T> extends State<TouchRipple<T>> with TouchRippleContext, TickerProviderStateMixin {
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
  void didUpdateWidget(TouchRipple<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != null && oldWidget.controller != widget.controller) {
      _controller = widget.controller!..delegateFrom(_controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _renderOrderType =
         widget.renderOrderType
      ?? style?.renderOrderType
      ?? TouchRippleRenderOrderType.background;

    return TouchRippleGestureDetector<T>(
      onTap: widget.onTap,
      onTapAsync: widget.onTapAsync,
      onTapAsyncStart: widget.onTapAsyncStart,
      onTapAsyncEnd: widget.onTapAsyncEnd,
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
      behavior: widget.hitBehavior ?? HitTestBehavior.translucent,
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
    return widget.rippleColor
        ?? style?.rippleColor
        ?? const Color.fromRGBO(0, 0, 0, 0.2);
  }

  @override
  Color get hoverColor {
    return widget.hoverColor
        ?? style?.hoverColor
        ?? TouchRippleColor.withAlphaOf(rippleColor, 0.5);
  }

  @override
  Color get focusColor {
    return widget.focusColor
        ?? style?.focusColor
        ?? TouchRippleColor.withAlphaOf(rippleColor, 0.5);
  }

  @override
  double get rippleScale {
    return widget.rippleScale
        ?? style?.rippleScale
        ?? 1;
  }

  @override
  double get rippleBlurRadius {
    return widget.rippleBlurRadius
        ?? style?.rippleBlurRadius
        ?? 10;
  }

  @override
  BorderRadius get rippleBorderRadius {
    return widget.rippleBorderRadius
        ?? style?.rippleBorderRadius
        ?? BorderRadius.zero;
  }

  @override
  Duration get previewDuration {
    return widget.previewDuration
        ?? style?.previewDuration
        ?? Duration(milliseconds: 100);
  }

  @override
  Duration get tappableDuration {
    return widget.tappableDuration
        ?? style?.tappableDuration
        ?? Duration.zero;
  }

  @override
  Duration get doubleTappableDuration {
    return widget.doubleTappableDuration
        ?? style?.doubleTappableDuration
        ?? Duration(milliseconds: 200);
  }

  @override
  Duration get doubleTapAliveDuration {
    return widget.doubleTapAliveDuration
        ?? style?.doubleTapAliveDuration
        ?? Duration(milliseconds: 1000);
  }

  @override
  Duration get longTappableDuration {
    return widget.longTappableDuration
        ?? style?.longTappableDuration
        ?? Duration(milliseconds: 200);
  }

  @override
  Duration get longTapCycleDuration {
    return widget.longTapCycleDuration
        ?? style?.longTapCycleDuration
        ?? Duration(milliseconds: 500);
  }

  @override
  TouchRippleBehavior get tapBehavior {
    return const TouchRippleBehavior(
      lowerPercent: 0.3,
      upperPercent: 1,
      spreadDuration: Duration(milliseconds: 300),
      spreadCurve: Curves.ease,
      fadeInDuration: Duration(milliseconds: 100),
      fadeInCurve: Curves.easeOut,
      fadeOutDuration: Duration(milliseconds: 200),
      fadeOutCurve: Curves.easeIn,
      cancelDuration: Duration(milliseconds: 100),
      cancelCurve: Curves.easeIn,
      fadeLowerPercent: 0,
      fadeUpperPercent: 1,
      eventCallBackableMinPercent: 0,
      onlyMainButton: true
    )
    .merge(style?.tapBehavior)
    .merge(widget.tapBehavior);
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
      .merge(const TouchRippleBehavior(
        lowerPercent: 0,
        upperPercent: 1,
        spreadDuration: Duration(milliseconds: 1000),
        spreadCurve: Curves.linear,
        fadeInDuration: Duration(milliseconds: 1000),
        fadeInCurve: Curves.linear
      ))
      .merge(style?.longTapBehavior)
      .merge(widget.longTapBehavior);
  }

  @override
  TouchRippleRejectBehavior get rejectBehavior {
    return widget.rejectBehavior
        ?? style?.rejectBehavior
        ?? TouchRippleRejectBehavior.leave;
  }

  @override
  TouchRippleCancelBehavior get cancelBehavior {
    return widget.cancelBehavior
        ?? style?.cancelBehavior
        ?? TouchRippleCancelBehavior.none;
  }

  @override
  TouchRippleOverlapBehavior get overlapBehavior {
    return widget.overlapBehavior
        ?? style?.overlapBehavior
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
  TouchRippleOrigin get origin {
    return widget.origin
        ?? style?.origin
        ?? TouchRippleOrigin.pointer_move;
  }

  @override
  bool get useHoverEffect {
    return widget.useHoverEffect
        ?? style?.useHoverEffect
        ?? true;
  }

  @override
  bool get useFocusEffect {
    return widget.useFocusEffect
        ?? style?.useFocusEffect
        ?? true;
  }
}