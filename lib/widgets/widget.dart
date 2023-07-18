import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_touch_ripple/components/behavior.dart';
import 'package:flutter_touch_ripple/components/controller.dart';
import 'package:flutter_touch_ripple/components/gestures/mixins.dart';
import 'package:flutter_touch_ripple/components/gestures/recognizers.dart';
import 'package:flutter_touch_ripple/components/states.dart';
import 'package:flutter_touch_ripple/widgets/gesture_detactor.dart';
import 'package:flutter_touch_ripple/widgets/stack.dart';





/// This enum is used to defines the render order of a touch ripple effects.
enum TouchRippleRenderOrderType {
  /// This value Defines that the touch ripple should be rendered
  /// in front of other elements
  foreground,
  /// This value Defines that the touch ripple should be rendered
  /// behind other elements.
  background,
}

/// This function type defines the perform to take when the gesture events.
typedef TouchRippleEventCallBack = VoidCallback;

/// The returned value defines a callback function to call when
/// the asynchronous to take is successfully performed.
typedef TouchRippleEventAsyncCallBack = Future<VoidCallback?> Function(void);

/// This function defines the action to take when a touch ripple event
/// has started or ended.
typedef TouchRippleStateCallBack = VoidCallback;

/// The [count] given defines the number of times the event occurs in a row,
/// The value returned is whether the events can occur in succession.
typedef TouchRippleContinuableCheckedCallBack = bool Function(int count);

/// An abstract stateful widget declared to handle click-related
/// events and display them visually to the user.
/// 
/// See also:
/// - Generic [T] defines a type of [TouchRippleGestureDetectorWidget],
///   which is itself created by the widget.
abstract class GestureDectectorCreatable<T extends TouchRippleGestureDetectorWidget> extends StatefulWidget {
  const GestureDectectorCreatable({
    super.key,
    required this.child,
    required this.onTap,
    // required this.onTapAsync,
    required this.onDoubleTap,
    required this.onDoubleTapStart,
    required this.onDoubleTapEnd,
    required this.onLongTap,
    required this.onLongTapStart,
    required this.onLongTapEnd,
    required this.onHorizontalDragStart,
    required this.onHorizontalDragUpdate,
    required this.onHorizontalDragEnd,
    required this.onVerticalDragStart,
    required this.onVerticalDragUpdate,
    required this.onVerticalDragEnd,
    required this.behavior,
    required this.tapBehavior,
    required this.doubleTapBehavior,
    required this.longTapBehavior,
    required this.onHoverStart,
    required this.onHoverEnd,
    required this.onFocusStart,
    required this.onFocusEnd,
    required this.hoverColor,
    required this.hoverFadeInDuration,
    required this.hoverFadeInCurve,
    required this.hoverFadeOutDuration,
    required this.hoverFadeOutCurve,
    required this.isDoubleTapContinuable,
    required this.isLongTapContinuable,
    required this.rejectBehavior,
    required this.cancelledBehavior,
    required this.longTapFocusStartEvent,
    required this.rippleColor,
    required this.renderOrder,
    required this.rippleScale,
    required this.tapableDuration,
    required this.hitTestBehavior,
    required this.doubleTappableDuration,
    required this.doubleTapHoldDuration,
    required this.longTappableDuration,
    required this.longTapStartDeleyDuration,
    required this.tapPreviewMinDuration,
    required this.controller,
    required this.borderRadius,
    required this.onDoubleTapContinuableChecked,
    required this.hoverCursor,
    required this.hoverColorRelativeOpacity,
    required this.focusColorRelativeOpacity,
    required this.useHoverEffect,
    required this.useFocusEffect,
    required this.focusColor,
    required this.focusFadeInDuration,
    required this.focusFadeInCurve,
    required this.focusFadeOutDuration,
    required this.focusFadeOutCurve,
    required this.useDoubleTapFocusEffect,
    required this.useLongTapFocusEffect,
    required this.isOnHoveredDisableFocusEffect,
    /*
    required this.isApplyClip,
    required this.pointerCenterApplySize,'
    */
  }) :  assert(
          tapableDuration != Duration.zero,
          'The tappable duration cannot be zero.'
          'If the tappable duration is zero, tapping will not occur in all situations.'
        ),
        assert(
          onDoubleTap == null ? onDoubleTapStart == null : true,
          'The onDoubleTap parameter is not givend, so the double tap gesture is not defined.'
          'Therefore, the onDoubleTapStart function is not called'
        ),
        assert(
          onDoubleTap == null ? onDoubleTapEnd == null : true,
          'The onDoubleTap parameter is not givend, so the double tap gesture is not defined.'
          'Therefore, the onDoubleTapEnd function is not called'
        ),
        assert(
          rippleScale >= 1,
          'The ripple size cannot be smaller than its original size. Please adjust the scale to be 1 or larger.'
        ),
        assert(
          !(isDoubleTapContinuable == false && onDoubleTapContinuableChecked != null),
          'Already defined to prevent consecutive double taps from occurring.'
          'Therefore, even if you register the onDoubleTapContinuationableChecked callback function,'
          'it will not be called.'
        );

  /// The [child] widget contained by the [TouchRipple] widget.
  /// 
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// {@template touch_ripple.onTap}
  /// Defines a function that is called when the user taps on that widget.
  /// {@endtemplate}
  final TouchRippleEventCallBack? onTap;
  
  /* Upcoming updates
  /// {@macro touch_ripple.onTap}
  final TouchRippleEventAsyncCallBack? onTapAsync;
  */

  /// Defines a function that is called when the user double taps on that widget.
  final TouchRippleEventCallBack? onDoubleTap;
  
  final TouchRippleContinuableCheckedCallBack? onDoubleTapContinuableChecked;

  /// Defines a function that is called when a double tap event
  /// occurs and enters the double tap state.
  final TouchRippleStateCallBack? onDoubleTapStart;

  /// Defines a function that is called when a double tap event
  /// is fired and the double tap state has ended.
  final TouchRippleStateCallBack? onDoubleTapEnd;

  /// Defines a function that is called when the user long tap on that widget.
  final TouchRippleContinuableCheckedCallBack? onLongTap;

  /// Defines a function that is called when a long tap event
  /// occurs and enters the long tap state.
  final TouchRippleStateCallBack? onLongTapStart;

  /// Defines a function that is called when a long tap event
  /// is fired and the long tap state has ended.
  final TouchRippleStateCallBack? onLongTapEnd;
  
  /// Defines a callback function that is called when the user drags
  /// a certain distance horizontally.
  /// 
  /// See also:
  /// - Here, the certain distance is [kTouchSlop].
  final TouchRippleEventCallBack? onHorizontalDragStart;
  
  /// Defines a callback function that is called if
  /// the pointer has been updated when the gesture is defined
  /// as dragging horizontally.
  final TouchRippleEventCallBack? onHorizontalDragUpdate;

  /// Defines a callback function that is called when the gesture
  /// is defined as dragging horizontally and then when gesture detection ends.
  final TouchRippleEventCallBack? onHorizontalDragEnd;

  /// Defines a callback function that is called when the user drags
  /// a certain distance vertically.
  /// 
  /// See also:
  /// - Here, the certain distance is [kTouchSlop].
  final TouchRippleEventCallBack? onVerticalDragStart;

  /// Defines a callback function that is called if
  /// the pointer has been updated when the gesture is defined
  /// as dragging vertically.
  final TouchRippleEventCallBack? onVerticalDragUpdate;

  /// Defines a callback function that is called when the gesture
  /// is defined as dragging vertically and then when gesture detection ends.
  final TouchRippleEventCallBack? onVerticalDragEnd;

  /// Defines a function that is called when a hover event
  /// occurs and enters the hover state.
  /// 
  /// See also:
  /// - Stylus is not detected here (flutter not supported)
  final TouchRippleStateCallBack? onHoverStart;
  
  /// Defines a function that is called when the hover state ends.
  /// 
  /// See also:
  /// - Stylus is not detected here (flutter not supported)
  final TouchRippleStateCallBack? onHoverEnd;

  /// Defines a callback function that is called when the transitions to the focus state.
  /// 
  /// {@template touch_ripple.focusState}
  /// See also:
  /// - The focus state is a state in which the gesture can continue to detect and process pointers.
  /// 
  ///   For example, a double tap state can be defined as a state in which
  ///   the widget continues to detect the pointer and define the gesture continuously.
  /// {@endtemplate}
  final TouchRippleStateCallBack? onFocusStart;
  
  /// Defines a callback function that is called when the focus state ends.
  /// 
  /// {@macro touch_ripple.focusState}
  final TouchRippleStateCallBack? onFocusEnd;

  /// Defines the default behavior of touch ripple all event.
  /// 
  /// See also:
  /// - If an behavior is not defined in the tap, double tap, or long tap events,
  ///   it will be defined as the value defined for that behavior.
  final TouchRippleBehavior? behavior;

  /// Return the default values for all the defined properties of a touch ripple.
  /// 
  /// See also:
  /// - The values of all properties of the returned instance must be defined and not null.
  /// - The value is not directly referenced externally.
  /// 
  /// Example:
  /// ```dart
  /// @override
  /// TouchRippleBehavior get defaultBehavior => TouchRippleBehavior(
  ///   overlap: TouchRippleOverlapBehavior.overlappable,
  ///   // ... All property values are defined.
  /// );
  /// ```
  TouchRippleBehavior get defaultBehavior;
  
  /// Returns the final defined touch ripple behavior of tap event.
  TouchRippleBehavior get defaultTapBehavior => defaultBehavior;

  /// Returns the final defined touch ripple behavior of double tap event.
  TouchRippleBehavior get defaultDoubleTapBehavior => defaultBehavior;

  /// Returns the final defined touch ripple behavior of long tap event.
  TouchRippleBehavior get defaultLongTapBehavior => defaultBehavior.copyWith(
    spreadDuration: const Duration(seconds: 1),
    spreadCurve: Curves.linear,
    fadeInDuration: const Duration(seconds: 1),
    fadeInCurve: Curves.linear,
    lowerPercent: 0,
  );

  /// Returns the final defined touch ripple behavior of horizontal drag event.
  TouchRippleBehavior get defaultHorizontalDragBehavior => defaultBehavior;

  /// Returns the final defined touch ripple behavior of horizontal drag event.
  TouchRippleBehavior get defaultVerticalDragBehavior => defaultBehavior;

  /// Defines the behavior applied when a tap event occurs.
  final TouchRippleBehavior? tapBehavior;

  /// Defines the behavior applied when a double tap event occurs.
  final TouchRippleBehavior? doubleTapBehavior;

  /// Defines the behavior applied when a long tap event occurs.
  final TouchRippleBehavior? longTapBehavior;

  /// Defines whether double tapping is allowed in succession.
  final bool isDoubleTapContinuable;

  /// Defines whether long tapping is allowed in succession.
  final bool isLongTapContinuable;

  /// Defines the touch ripple reject with pointer position behavior.
  final TouchRippleRejectBehavior rejectBehavior;
  
  /// Defines the behavior that causes the gesture to be cancelled.
  final TouchRippleCancelledBehavior cancelledBehavior;

  final TouchRippleLongTapFocusStartEvent longTapFocusStartEvent;
  
  /// Defines touch ripple background color of all events.
  final Color? rippleColor;

  /// Defines default touch ripple background color of all events.
  Color get defaultRippleColor; 

  /// Defines the background color of the hover effect shown when the mouse hovers.
  /// 
  /// See also:
  /// - If this argument is not defined, no action is taken on mouse hover
  ///    therefore, the hover effect is not implemented either.
  final Color? hoverColor;
  
  /// Defines fade-in duration of hover animatin.
  final Duration hoverFadeInDuration;

  /// Defines fade-in curve of hover curved animatin.
  final Curve hoverFadeInCurve;
  
  /// Defines fade-out duration of hover animatin.
  final Duration? hoverFadeOutDuration;
  
  /// Defines fade-out curve of hover curved animatin.
  final Curve? hoverFadeOutCurve;

  /// Defines scale of touch ripple effect size.
  final double rippleScale;

  /// [tapableDuration] defines the duration after which the tap event is
  /// canceled after the pointerDown event occurs,
  /// 
  /// In other words, in order to detect the point and have the tap event occur,
  /// the tap event must occur before the [tapableDuration].
  final Duration? tapableDuration;
  
  /// Defines the order in which the touch ripple effect is drawn.
  final TouchRippleRenderOrderType renderOrder;

  /// Same as [HitTestBehavior] of [RawGestureDetector].
  final HitTestBehavior hitTestBehavior;
  
  /// The duration between two taps that is considered a double tap,
  /// This refers to the time interval used to recognize double taps.
  /// 
  /// See also:
  /// - If a tap occurs and a tap occurs again before [doubleTappableDuration],
  ///    it is considered a double tap.
  final Duration? doubleTappableDuration;

  /// Defines the minimum duration to end the double tap state.
  /// 
  /// If a double tap state starts and no tap events occur during that duration,
  /// the double tap state ends.
  final Duration? doubleTapHoldDuration;

  /// Defines the minimum duration define as a long tap.
  /// 
  /// See also:
  /// - A pointer down event is defined as a long tap when it occurs and a duration
  ///   of [longTappableDuration] or more has elapsed.
  /// 
  /// - If the value is not defined,
  ///   it is replaced by the spread duration of the long tap behavior.
  final Duration? longTappableDuration;

  /// Defines the amount of duration that must elapse before a long press
  /// gesture is considered initiated.
  /// 
  /// See also:
  /// - For example if that value is defined as 500 milliseconds,
  ///   the long press action is not considered to have started until the user has held down
  ///   the widget for at least 500 milliseconds.
  final Duration longTapStartDeleyDuration;
  
  /// The minimum duration to wait before showing the preview tap effect,
  /// if no other events need to be considered.
  final Duration? tapPreviewMinDuration;

  /// This is the controller you define when you need to manage touch ripple effects externally.
  final TouchRippleController? controller;

  /// Same as [BorderRadius] of [ClipRRect].
  final BorderRadius borderRadius;

  /// Defines the mouse cursor that is visible when hovering with the mouse.
  final SystemMouseCursor hoverCursor;

  /// Defines what percentage of ripple color opacity the default hover color
  /// will be defined as when no hover color is artificially defined.
  final double hoverColorRelativeOpacity;

  /// Defines what percentage of ripple color opacity the default focus color
  /// will be defined as when no focus color is artificially defined.
  final double focusColorRelativeOpacity;
  
  /// Defines whether a hover effect should be used throughout.
  final bool useHoverEffect;

  /// Defines whether a focus effect should be used throughout.
  final bool useFocusEffect;

  /// Defines the background colour of the focus effect that occurs on focus.
  final Color? focusColor;
  
  /// Defines fade-in duration of focus animatin.
  final Duration focusFadeInDuration;

  /// Defines fade-in curve of focus curved animatin.
  final Curve focusFadeInCurve;
  
  /// Defines fade-out duration of focus animatin.
  final Duration? focusFadeOutDuration;

  /// Defines fade-out curve of focus curved animatin.
  final Curve? focusFadeOutCurve;

  /// Defines whether to use the focus effect on double tap state.
  final bool useDoubleTapFocusEffect;

  /// Defines whether to use the focus effect on long tap state.
  final bool useLongTapFocusEffect;

  /// Defines whether to disable the focus effect when in a hover state.
  final bool isOnHoveredDisableFocusEffect;
  
  /* Upcoming updates
  final bool isApplyClip;

  final Size? pointerCenterApplySize;
  */
  
  /// Create a new instance of the [T] widget that extends from [TouchRippleGestureDetactorWidget].
  T createGestureDetector({
    required Widget child,
    TouchRippleRecognizerCallback? onTap,
    TouchRippleRejectableCallback? onRejectableTap,
    TouchRippleRecognizerCountableCallback? onDoubleTap,
    TouchRippleStateCallBack? onDoubleTapStart,
    TouchRippleStateCallBack? onDoubleTapEnd,
    TouchRippleRejectableCallback? onRejectableLongTap,
    TouchRippleStateCallBack? onLongTapStart,
    TouchRippleStateCallBack? onLongTapEnd,
    TouchRippleRecognizerCallback? onCancel,
    TouchRippleAcceptedCallback? onAccepted,
    TouchRippleRejectedCallback? onRejected,
  });
  
  /// Create a new instance of the [TouchRippleController],
  /// 
  /// Called to create a new controller instance from an abstract class when
  /// the given controller does not exist and cannot be referenced.
  /// 
  /// See also:
  /// - [TouchRipple.controller]
  TouchRippleController createTouchRippleController() => TouchRippleController();

  /// Finds the [TouchRippleWidgetState] from the closest instance
  /// of this class that encloses the given context.
  static TouchRippleWidgetState? of(BuildContext context) {
    return context.findAncestorStateOfType<TouchRippleWidgetState>();
  }
}

/// Customizable touch ripple for flutter widget
/// 
/// - This package has been developed to resemble Android touch ripple effects.
///    Additionally, it allows for easy definition
///    and customization of animations, features, or actions.
/// - - -
/// 
/// `The following describes how to make the declaration.`
/// 
/// Example:
/// ```dart
/// TouchRipple(
///     onTap: () => print('Hello World!'),
///     child: ... // <- this your widget!
/// ),
/// ```
/// 
/// How to make sure your event callback function is called
/// after the touch ripple effect is complete:
/// ```dart
/// TouchRipple(
///   behavior: TouchRippleBehavior(
///     // Define that the event callback function can be called when
///     // the touch ripple spreading degree is 100%.
///     eventCallBackableMinPercent: 1,
///   ),
///   child: Container(),
/// );
/// ```
/// 
/// - - -
/// See also:
/// - A widget declared to handle click-related events and display them visually to the user.
class TouchRipple extends GestureDectectorCreatable {
  const TouchRipple({
    super.key,
    required super.child,
    super.onTap,
    super.onDoubleTap,
    super.onDoubleTapStart,
    super.onDoubleTapEnd,
    super.onLongTap,
    super.onLongTapStart,
    super.onLongTapEnd,
    super.onHorizontalDragStart,
    super.onHorizontalDragUpdate,
    super.onHorizontalDragEnd,
    super.onVerticalDragStart,
    super.onVerticalDragUpdate,
    super.onVerticalDragEnd,
    super.behavior,
    super.tapBehavior,
    super.doubleTapBehavior,
    super.longTapBehavior,
    super.onHoverStart,
    super.onHoverEnd,
    super.onFocusStart,
    super.onFocusEnd,
    super.hoverColor,
    super.hoverFadeInDuration = const Duration(milliseconds: 75),
    super.hoverFadeInCurve = Curves.easeOut,
    super.hoverFadeOutDuration,
    super.hoverFadeOutCurve,
    super.isDoubleTapContinuable = true,
    super.isLongTapContinuable = true,
    super.rejectBehavior = TouchRippleRejectBehavior.leave,
    super.cancelledBehavior = TouchRippleCancelledBehavior.none,
    super.longTapFocusStartEvent = TouchRippleLongTapFocusStartEvent.onRejectable,
    super.rippleColor,
    super.renderOrder = TouchRippleRenderOrderType.foreground,
    super.rippleScale = 1,
    super.tapableDuration,
    super.hitTestBehavior = HitTestBehavior.translucent,
    super.doubleTappableDuration = const Duration(milliseconds: 250),
    super.doubleTapHoldDuration = const Duration(milliseconds: 750),
    super.longTappableDuration,
    super.longTapStartDeleyDuration = const Duration(milliseconds: 150),
    super.tapPreviewMinDuration = const Duration(milliseconds: 150),
    super.controller,
    super.borderRadius = BorderRadius.zero,
    super.onDoubleTapContinuableChecked,
    super.hoverCursor = SystemMouseCursors.click,
    super.hoverColorRelativeOpacity = 0.4,
    super.focusColorRelativeOpacity = 0.4,
    super.useHoverEffect = true,
    super.useFocusEffect = true,
    super.focusColor,
    super.focusFadeInDuration = const Duration(milliseconds: 150),
    super.focusFadeInCurve = Curves.easeOut,
    super.focusFadeOutDuration,
    super.focusFadeOutCurve,
    super.useDoubleTapFocusEffect = true,
    super.useLongTapFocusEffect = true,
    super.isOnHoveredDisableFocusEffect = false,
  });

  @override
  TouchRippleBehavior get defaultBehavior => const TouchRippleBehavior(
    overlap: TouchRippleOverlapBehavior.overlappable,
    lowerPercent: 0.3,
    upperPercent: 1,
    fadeLowerPercent: 0,
    fadeUpperPercent: 1,
    eventCallBackableMinPercent: null,
    spreadDuration: Duration(milliseconds: 200),
    spreadCurve: Curves.easeOutQuad,
    fadeInDuration: Duration(milliseconds: 100),
    fadeInCurve: Curves.easeOut,
    fadeOutDuration: Duration(milliseconds: 250),
    fadeOutCurve: Curves.easeIn,
    canceledDuration: Duration(milliseconds: 50),
    canceledCurve: null,
  );

  @override
  Color get defaultRippleColor => Colors.black.withAlpha(75);

  @override
  State<TouchRipple> createState() => TouchRippleWidgetState();

  @override
  createGestureDetector({
    required Widget child,
    TouchRippleRecognizerCallback? onTap,
    TouchRippleRejectableCallback? onRejectableTap,
    TouchRippleRecognizerCountableCallback? onDoubleTap,
    TouchRippleStateCallBack? onDoubleTapStart,
    TouchRippleStateCallBack? onDoubleTapEnd,
    TouchRippleRejectableCallback? onRejectableLongTap,
    TouchRippleRecognizerCountableCallback? onLongTap,
    TouchRippleStateCallBack? onLongTapStart,
    TouchRippleStateCallBack? onLongTapEnd,
    TouchRippleRecognizerCallback? onCancel,
    TouchRippleAcceptedCallback? onAccepted,
    TouchRippleRejectedCallback? onRejected,
    TouchRippleFocusStartStateCallBack? onFocusStart,
    TouchRippleStateCallBack? onFocusEnd,
    Duration? longTappableDuration,
  }) {
    Duration? tapPreviewMinDuration = super.tapPreviewMinDuration;

    // If long tap gesture are defined,
    // the tap gesture need to compete with long tap gesture,
    // so it is not possible to show the tap effect in advance to the user.
    if (onLongTap != null) {
      tapPreviewMinDuration = null;
    } else if (tapPreviewMinDuration != null) {
      if (onDoubleTap != null) {
        tapPreviewMinDuration += super.doubleTappableDuration!;
      }
    }

    return TouchRippleGestureDetector(
      behavior: super.hitTestBehavior,
      rejectBehavior: super.rejectBehavior,
      longTapFocusStartEvent: super.longTapFocusStartEvent,
      tapPreviewMinDuration: tapPreviewMinDuration,
      tapableDuration: super.tapableDuration,
      doubleTappableDuration: super.doubleTappableDuration,
      doubleTapHoldDuration: super.doubleTapHoldDuration,
      longTappableDuration: longTappableDuration,
      longTapStartDeleyDuration: super.longTapStartDeleyDuration,
      onTap: onTap,
      onRejectableTap: onRejectableTap,
      onDoubleTap: onDoubleTap,
      onDoubleTapStart: onDoubleTapStart,
      onDoubleTapEnd: onDoubleTapEnd,
      onRejectableLongTap: onRejectableLongTap,
      onLongTap: onLongTap,
      onLongTapStart: onLongTapStart,
      onLongTapEnd: onLongTapEnd,
      onAccepted: onAccepted,
      onRejected: onRejected,
      onFocusStart: onFocusStart,
      onFocusEnd: onFocusEnd,
      child: child,
    );
  }
}

class TouchRippleWidgetState extends State<TouchRipple> {
  /// If the controller is not given as an argument in the given state,
  /// The function is called internally to create the controller and return
  /// a new instance of the touch ripple controller.
  /// 
  /// This is because the existence of the controller is essential for managing the touch ripple state.
  late TouchRippleController controller = widget.controller ?? widget.createTouchRippleController();

  /// Convert the two given touch ripple behaviors to null safety instances and return them.
  /// 
  /// Arguments:
  /// - The given [behavior] is a custom behavior defined in the widget state.
  /// 
  /// - The given [defaultBehavior] is the default behavior defined
  ///    in the widget implementation class.
  static TouchRippleBehavior _toNullSafetedBehavior({
    required TouchRippleBehavior? behavior,
    required TouchRippleBehavior defaultBehavior,
  }) {
    // If behavior is not null,
    // it means that the user specified a custom behavior, 
    // so we use the pasteWith method to return a combination of
    // the defaultBehavior and the behavior.
    if (behavior != null) return defaultBehavior.pasteWith(behavior);
                                     return defaultBehavior;
  }

  /// Returns null safeted touch ripple tap default behavior.
  TouchRippleBehavior get defaultBehavior {
    return _toNullSafetedBehavior(
      behavior: widget.behavior,
      defaultBehavior: widget.defaultTapBehavior,
    );
  }

  /// Returns null safeted touch ripple tap behavior.
  TouchRippleBehavior get tapBehavior {
    return _toNullSafetedBehavior(
      behavior: widget.tapBehavior,
      defaultBehavior: widget.defaultBehavior,
    );
  }

  /// Returns null safeted touch ripple double tap behavior.
  TouchRippleBehavior get doubleTapBehavior {
    return _toNullSafetedBehavior(
      behavior: widget.doubleTapBehavior,
      defaultBehavior: widget.defaultBehavior,
    );
  }

  /// Returns null safeted touch ripple long tap behavior.
  TouchRippleBehavior get longTapBehavior {
    TouchRippleBehavior? behavior = widget.defaultLongTapBehavior;
    if (widget.longTapBehavior != null) {
      behavior = behavior.pasteWith(widget.longTapBehavior!);
    }

    return _toNullSafetedBehavior(
      behavior: behavior,
      defaultBehavior: widget.defaultBehavior,
    );
  }

  /// Returns current defined touch ripple color.
  Color get rippleColor => widget.rippleColor ?? widget.defaultRippleColor;

  @override
  void initState() {
    super.initState();

    controller.isOnHoveredDisableFocusEffect
      = widget.isOnHoveredDisableFocusEffect;
  }

  @override
  void didUpdateWidget(covariant TouchRipple oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// If the old ad controller needs to be replaced,
    /// the existing states will be retained and delegated to the new controller.
    if (widget.controller != null
    && oldWidget.controller != null
    && widget.controller != oldWidget.controller) {
      controller = widget.controller!..pasteWith(controller);
    }

    if(widget.rejectBehavior != oldWidget.rejectBehavior) {
      setState(() {
        // The child widget should update with the updated setting value.
      });
    }

    controller.isOnHoveredDisableFocusEffect
      = widget.isOnHoveredDisableFocusEffect;
  }

  /// Returns whether the currently active touch ripple effect should be cancelled,
  /// referencing the given touch ripple behavior.
  bool _checkShouldCancelled({
    required TouchRippleBehavior behavior,
  }) {
    /// If a given behavior defines that ripple effects cannot overlap,
    /// and there are currently actived effects, the actived effect must be cancelled.
    return behavior.overlap == TouchRippleOverlapBehavior.cancel
        && controller.rippleStates.isNotEmpty;
  }

  /// nspects the given behavior and creates a new TouchRippleState accordingly.
  /// 
  /// See also:
  /// - Returns null if the ripple effect should be ignored.
  TouchRippleState? _inspectCreateState({
    required TouchRippleBehavior behavior,
    required TouchRippleState Function() onCreateState,
  }) {
    // If defined that a given behavior should cancel active ripple effects
    // if they overlap in effect,
    // and there are currently active ripple effects,
    // it will cancel all of them.
    if (_checkShouldCancelled(behavior: behavior)) {
      controller.rippleStates.toList().forEach((e) => e.cancel(cancelledBehavior: widget.cancelledBehavior));
    }

    /// If a given behavior is defined to ignore an event
    /// if it would cause an overlapping effect,
    /// it will not generate a touch ripple effect if there is currently an active ripple effect.
    if (behavior.overlap == TouchRippleOverlapBehavior.ignoring
     && controller.rippleStates.isNotEmpty) {
      return null;
    }
    return onCreateState.call();
  }

  /// Attaches the given state to the controller defined in the current widget state.
  void stateByAttach(TouchRippleState? state) {
    if (state != null) controller.attach(state);
  }

  /// Returns a new instance of [GestureDetector] corresponding to the given [child].
  Widget createGestureDetector({
    required Widget child,
    TouchRippleEventCallBack? onTap,
    TouchRippleEventCallBack? onDoubleTap,
    TouchRippleStateCallBack? onDoubleTapStart,
    TouchRippleStateCallBack? onDoubleTapEnd,
    TouchRippleContinuableCheckedCallBack? onLongTap,
    TouchRippleStateCallBack? onLongTapStart,
    TouchRippleStateCallBack? onLongTapEnd,
    TouchRippleStateCallBack? onFocusStart,
    TouchRippleStateCallBack? onFocusEnd,
  }) {
    TouchRippleRecognizerCallback? tapCallback;
    TouchRippleRejectableCallback? rejectableTapCallback;
    TouchRippleRecognizerCountableCallback? doubleTapCallback;
    TouchRippleRecognizerCountableCallback? longTapCallback;
    TouchRippleRejectableCallback? rejectableLongTapCallback;
    // TouchRippleRecognizerCallback? onHorizontalDragCallback;
    // TouchRippleRecognizerCallback? onVerticalDragCallback;
    
    if (onTap != null) {
      TouchRippleState createTouchRippleState(Offset baseOffset, {required bool isRejectable}) {
        final newState = controller.createState(
          behavior: tapBehavior,
          callback: onTap,
          eventedOffset: baseOffset,
          isRejectable: isRejectable,
        );
        return newState;
      }

      tapCallback = (Offset acceptedOffset) {
        final newState = _inspectCreateState(
          behavior: tapBehavior,
          onCreateState: () => createTouchRippleState(acceptedOffset, isRejectable: false),
        );
        stateByAttach(newState?..start());
      };

      rejectableTapCallback = (rejectableOffset) {
        final newState = createTouchRippleState(rejectableOffset, isRejectable: true);
        stateByAttach(newState..start());

        return newState;
      };
    }
    if (onDoubleTap != null) {
      TouchRippleState createTouchRippleState(Offset baseOffset) {
        final newState = controller.createState(
          behavior: doubleTapBehavior,
          callback: onDoubleTap,
          eventedOffset: baseOffset,
          isRejectable: false,
        );
        return newState;
      }

      doubleTapCallback = (acceptedOffset, count) {
        final newState = _inspectCreateState(
          behavior: doubleTapBehavior,
          onCreateState: () => createTouchRippleState(acceptedOffset),
        );
        stateByAttach(newState?..start());
        
        if (widget.isDoubleTapContinuable == false) return false;
        return widget.onDoubleTapContinuableChecked?.call(count)
            ?? widget.isDoubleTapContinuable;
      };
    }
    if (widget.onLongTap != null) {
      TouchRippleState createTouchRippleState(Offset baseOffset) {
        final newState = controller.createState(
          behavior: longTapBehavior,
          callback: () {},
          eventedOffset: baseOffset,
          isRejectable: true,
        );
        return newState;
      }
      
      longTapCallback = (acceptedOffset, count) {
        return onLongTap?.call(count) ?? false;
      };
      rejectableLongTapCallback = (rejectableOffset) {
        final newState =  createTouchRippleState(rejectableOffset);
                          stateByAttach(newState..start());

        return newState;
      };
    }
    /*
    if (widget.onHorizontalDragStart != null
     || widget.onHorizontalDragUpdate != null
     || widget.onHorizontalDragEnd != null) {
      onHorizontalDragCallback = (acceptedOffset) {
        
      };
    }
    */

    TouchRippleFocusStartStateCallBack? focusStartCallBack;
    TouchRippleStateCallBack? focusEndCallBack;

    // The following code block takes the task of defining
    // the focus event callback functions.
    {
      focusStartCallBack = (instance) {
        if (widget.useFocusEffect == false) return;
        if (widget.useDoubleTapFocusEffect == false
         && instance is TouchRippleDoubleTapGestureRecognizer
         || widget.useLongTapFocusEffect == false
         && instance is TouchRippleLongTapGestureRecognizer) return;

        // If focus state already initialised,
        // it will fade back in without creating the state.
        if (controller.focusState == null) {
          Color getDefaultFocusColor() {
            return rippleColor.withAlpha(
              (rippleColor.alpha * widget.focusColorRelativeOpacity).toInt()
            );
          }
          
          final newState = controller.createBackgroundState(
            color: widget.focusColor ?? getDefaultFocusColor(),
            fadeInDuration: widget.focusFadeInDuration,
            fadeInCurve: widget.focusFadeInCurve,
            fadeOutDuration: widget.focusFadeOutDuration,
            fadeOutCurve: widget.focusFadeOutCurve,
            onDispatch: () {
              controller.focusState?.dispose();
              controller.focusState = null;
            },
          );
          controller.focusState = newState;
        }
        controller.focusState?.fadeIn();
        onFocusStart?.call();
      };
      focusEndCallBack = () {
        controller.focusState?.fadeOut();

        onFocusEnd?.call();
      };
    }

    /// Create gesture detector corresponding to the initialised
    /// gesture event callback functions.
    return widget.createGestureDetector(
      onTap: tapCallback,
      onRejectableTap: rejectableTapCallback,
      onDoubleTap: doubleTapCallback,
      onDoubleTapStart: onDoubleTapStart,
      onDoubleTapEnd: onDoubleTapEnd,
      onLongTap: longTapCallback,
      onRejectableLongTap: rejectableLongTapCallback,
      onLongTapStart: onLongTapStart,
      onLongTapEnd: onLongTapEnd,
      onAccepted: (acceptedState) => acceptedState.onAccepted(),
      onRejected: (rejectedState) => rejectedState.onRejected(),
      onFocusStart: focusStartCallBack,
      onFocusEnd: focusEndCallBack,
      longTappableDuration: widget.longTappableDuration ?? longTapBehavior.spreadDuration,
      child: child,
    );
  }
  
  /// Before building the widget, if there are callback functions
  /// for the given events, necessary callback functions with
  /// defined touch ripple effect logic will be defined for those events.
  /// 
  /// Then, the defined callback functions are passed directly to
  /// the widget responsible for managing gestures as its child widget.
  @override
  Widget build(BuildContext context) {
    final gestureDetector = createGestureDetector(
      onTap: widget.onTap,
      onDoubleTap: widget.onDoubleTap,
      onDoubleTapStart: widget.onDoubleTapStart,
      onDoubleTapEnd: widget.onDoubleTapEnd,
      onLongTap: widget.onLongTap,
      onLongTapStart: widget.onLongTapStart,
      onLongTapEnd: widget.onLongTapEnd,
      onFocusStart: widget.onFocusStart,
      onFocusEnd: widget.onFocusEnd,
      child: TouchRippleStack(
        renderOrder: widget.renderOrder,
        rippleColor: rippleColor,
        rippleScale: widget.rippleScale,
        borderRadius: widget.borderRadius,
        controller: controller,
        child: widget.child,
      ),
    );
    
    // If current platform is touch-based,
    // don't need to define mouse-related behaviours.
    //
    // Even if hover is considered,
    // the stylus hover listener functionality is no longer
    // supported in Flutter.
    if (Platform.isFuchsia
     || Platform.isAndroid
     || Platform.isIOS) return gestureDetector;

    PointerEnterEventListener? onHoverStartCallBack;
    PointerExitEventListener? onHoverEndCallBack;
    MouseCursor? cursor;
    
    // The following code block takes the task of defining
    // the mouse hover event callback functions.
    {
      onHoverStartCallBack = (event) {
        if (widget.useHoverEffect == false) return;

        // If hover state already initialised,
        // it will fade back in without creating the state.
        if (controller.hoverState == null) {
          Color getDefaultHoverColor() {
            return rippleColor.withAlpha(
              (rippleColor.alpha * widget.hoverColorRelativeOpacity).toInt()
            );
          }

          final newState = controller.createBackgroundState(
            color: widget.hoverColor ?? getDefaultHoverColor(),
            fadeInDuration: widget.hoverFadeInDuration,
            fadeInCurve: widget.hoverFadeInCurve,
            fadeOutDuration: widget.hoverFadeOutDuration,
            fadeOutCurve: widget.hoverFadeOutCurve,
            onDispatch: () {
              controller.hoverState?.dispose();
              controller.hoverState = null;
            },
          );
          controller.hoverState = newState;
        }
        controller.hoverState?.fadeIn();
        widget.onHoverStart?.call();
      };
      onHoverEndCallBack = (event) {
        controller.hoverState?.fadeOut();

        widget.onHoverEnd?.call();
      };
    }
    
    if (widget.onTap != null
     || widget.onDoubleTap != null
     || widget.onLongTap != null) {
      cursor = widget.hoverCursor;
    }
    return MouseRegion(
      onEnter: onHoverStartCallBack,
      onExit: onHoverEndCallBack,
      cursor: cursor ?? MouseCursor.defer,
      child: gestureDetector,
    );
  }
}