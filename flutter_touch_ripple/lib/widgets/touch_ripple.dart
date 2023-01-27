
import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_touch_ripple/components/start_on_event.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:flutter_touch_ripple/widgets/ripple_effect.dart';
import 'package:flutter_touch_ripple/widgets/ripple_foreground.dart';
import 'package:flutter_touch_ripple/widgets/ripple_stack.dart';



typedef OnPointer = void Function(PointerEvent event);

typedef OnPointerHover = void Function(PointerHoverEvent event);

typedef OnDoubleTap = bool Function(int count);

typedef OnLongPress = bool Function();



/// ## The [TouchRipple] widget is define your custom touch ripple effect.
/// 
/// See also:
/// * For enquiries or bugs, please send them to rootlouibooks@gmail.com.
/// * Refer to the appropriate code to implement page movement with the [Ripple].
/// ```dart
///   TouchRipple(
///     // Until the ripple effect end hold the call of the [Ripple.onTap],
///     // Prevents the ripple effect from being invisible and page shifting.
///     startOnTap: StartOnTap(isWait: true)
///   );
/// ```
class TouchRipple extends StatefulWidget {
  const TouchRipple({
    super.key,
    required this.child,
    this.clipBehavior = Clip.hardEdge,
    this.borderRadius = BorderRadius.zero,
    this.rippleRadius = BorderRadius.zero,
    this.cursor,
    this.doubleTapBehavior = DoubleTapBehavior.cancel,
    this.longPressBehavior = LongPressBehavior.cancel,
    this.overlapBehavior = RippleOverlapBehavior.cancel,
    RippleOverlapBehavior? tapOverlapBehavior,
    RippleOverlapBehavior? doubleTapOverlapBehavior,
    this.startTapEffect = StartTapRippleEffect.pointerDown,
    this.touchSlop = kTouchSlop,
    this.isActive = true,
    this.startOnTap = const StartOnEvent(isWait: false),
    this.startOnDoubleTap = const StartOnEvent(isWait: false),
    this.durationScale = 1,

    this.rippleColor = const Color.fromRGBO(255, 255, 255, 0.4),
    this.rippleColorTween,
    this.foregroundColor,
    this.foregroundColorTween,
    this.longPressRippleColor,
    this.longPressRippleColorTween,

    this.useEffect = true,
    bool? useTapEffect,
    bool? useDoubleTapEffect,
    bool? useLongPressEffect,
    this.useForeground = false,
    bool? useTapForeground,
    bool? useDoubleTapForeground,
    bool? useLongPressForeground,

    this.lowerPercent = 0.4,
    this.upperPercent = 1,
    double? tapLowerPercent,
    double? tapUpperPercent,
    double? doubleTapLowerPercent,
    double? doubleTapUpperPercent,
    double? longPressLowerPercent,
    double? longPressUpperPercent,

    this.scale = 1,
    double? tapScale,
    double? doubleTapScale,
    double? longPressScale,

    this.rippleDuration = const Duration(milliseconds: 150),
    this.rippleCurve = Curves.easeOut,
    this.rippleFadeInDuration = const Duration(milliseconds: 25),
    this.rippleFadeInCurve = Curves.easeIn,
    this.rippleFadeOutDuration = const Duration(milliseconds: 150),
    this.rippleFadeOutCurve = Curves.ease,
    this.canceledRippleDuration = Duration.zero,
    this.canceledRippleCurve = Curves.ease,
    this.longPressDuration = const Duration(seconds: 1),
    this.longPressCurve = Curves.linear,
    Duration? longPressFadeInDuration,
    this.longPressFadeInCurve = Curves.linear,
    this.longPressFadeOutDuration = const Duration(milliseconds: 100),
    this.longPressFadeOutCurve = Curves.ease,
    this.canceledLongPressDuration = Duration.zero,
    this.canceledLongPressCurve = Curves.ease,
    this.foregroundFadeInDuration = const Duration(milliseconds: 150),
    this.foregroundFadeInCurve = Curves.easeOut,
    this.foregroundFadeOutDuration = const Duration(milliseconds: 150),
    this.foregroundFadeOutCurve = Curves.easeIn,
    this.canceledForegroundDuration = Duration.zero,
    this.canceledForegroundCurve = Curves.easeIn,

    required this.onTap,
    this.onDoubleTap,
    this.onDoubleTapStart,
    this.onDoubleTapEnd,
    this.onLongPress,
    this.onHover,
    this.onHoverStart,
    this.onHoverEnd,
    this.onCancel,
    this.onPointerDown,
    this.onPointerMove,
    this.onPointerUp,
    this.onPointerCancel,

    this.tapableDuration = Duration.zero,
    this.doubleTapStateDuration = const Duration(milliseconds: 250),
    this.doubleTapStateCancellationDuration = const Duration(milliseconds: 500),
    this.startTapEffectDuration = const Duration(milliseconds: 100),
  }) : assert(!(lowerPercent > 1 || lowerPercent < 0), 'The value from is 0.0 to 1.0'),
       assert(!(upperPercent > 1 || upperPercent < 0), 'The value from is 0.0 to 1.0'),
       assert(!(scale <= 0), 'The scale must be greater than zero, If you do not want to use an ripple effect define useEffect as false'),
       assert(!(durationScale < 0), 'The duration spped scale must be greater than negative number'),
       assert(doubleTapStateDuration != Duration.zero, 'Must be greater than Duration.zero'),
       assert(doubleTapStateCancellationDuration != Duration.zero, 'Must be greater than Duration.zero'),

       tapOverlapBehavior = tapOverlapBehavior ?? overlapBehavior,
       doubleTapOverlapBehavior = doubleTapOverlapBehavior ?? overlapBehavior,

       useTapEffect = useTapEffect ?? useEffect,
       useDoubleTapEffect = useDoubleTapEffect ?? useEffect,
       useLongPressEffect = useLongPressEffect ?? useEffect,
       useTapForeground = useTapForeground ?? useForeground,
       useDoubleTapForeground = useDoubleTapForeground ?? useForeground,
       useLongPressForeground = useLongPressForeground ?? useForeground,

       tapLowerPercent = tapLowerPercent ?? lowerPercent,
       tapUpperPercent = tapUpperPercent ?? upperPercent,
       doubleTapLowerPercent = doubleTapLowerPercent ?? lowerPercent,
       doubleTapUpperPercent = doubleTapUpperPercent ?? upperPercent,
       longPressLowerPercent = longPressLowerPercent ?? lowerPercent,
       longPressUpperPercent = longPressUpperPercent ?? upperPercent,
       
       tapScale = tapScale ?? scale,
       doubleTapScale = doubleTapScale ?? scale,
       longPressScale = longPressScale ?? scale,

       longPressFadeInDuration = longPressFadeInDuration ?? longPressDuration;


  
  /// The [child] contained by the ripple widget,
  /// 
  /// * Widget to which ripple effects apply,
  /// * Depending on the size of the [child], the ripple effect is visible.
  final Widget child;

  /// clip of the [ClipRRect] contained by the ripple widget.
  final Clip clipBehavior;

  /// border radius of the [ClipRRect] contained by the ripple widget.
  final BorderRadius borderRadius;

  /// The border radius is referenced only by [RipplePainter] (ripple effect).
  final BorderRadius rippleRadius;
  
  /// Mouse cursor when in hover state.
  final SystemMouseCursor? cursor;
  
  /// behavior when double tabs occur continuously.
  final DoubleTapBehavior doubleTapBehavior;

  /// whether longpress can occur continuously.
  final LongPressBehavior longPressBehavior;

  /// all event type behavior when a ripple effect needs to be displayed
  /// when the ripple effect is not complete.
  /// 
  /// * Although not referenced, instead
  /// 
  ///   if [tapOverlapBehavior] or [doubleTapBehavior] is null
  ///   define the value as the [overlapBehavior].
  /// 
  final RippleOverlapBehavior overlapBehavior;
  
  /// tap event type behavior when a ripple effect needs to be
  /// displayed when the ripple effect is not complete.
  final RippleOverlapBehavior tapOverlapBehavior;

  /// double tap event type behavior when a ripple effect needs to be
  /// displayed when the ripple effect is not complete.
  final RippleOverlapBehavior doubleTapOverlapBehavior;

  /// The behavior on what events occur and forward ripple effect.
  /// 
  /// * If [onLongPress] is not null, the [startTapEffect] is not referenced or used.
  final StartTapRippleEffect startTapEffect;

  /// the distance at which the minimum pixel
  /// must be moved to accurately define the gesture.
  /// 
  /// * Pointer down -> Move more than [touchSlop] -> Cancel all ripple event
  /// * Must be adjust the [kTouchSlop] to prevent the scroll from being delayed
  ///   the [kTouchSlop] is recommend 5 to 8.
  /// 
  final double touchSlop;

  /// Whether to use the ripple widget and all events.
  final bool isActive;

  /// Define when [onTap] is called.
  /// 
  /// * If [StartOnEvent.isWait] is true Hold calls of [onTap] callback function
  ///   until the ripple effect ends.
  /// * Prevents the ripple effect from being invisible and replace page.
  /// 
  final StartOnEvent startOnTap;

  /// Define when [onDoubleTap] is called.
  /// 
  /// * If [StartOnEvent.isWait] is true Hold calls of [onDoubleTap] callback function
  ///   until the ripple effect ends.
  /// * Prevents the ripple effect from being invisible and replace page.
  /// 
  final StartOnEvent startOnDoubleTap;



  /// Ripple effect background color
  /// 
  /// * Colors referenced in [RippleEffect]
  /// * The [rippleColor] is not used unless [rippleColorTween] is null.
  /// 
  final Color rippleColor;

  /// Ripple effect background color tween
  final ColorTween? rippleColorTween;
  
  /// Ripple effect color in longpress state
  final Color? longPressRippleColor;

  /// Ripple effect color tween in longpress state
  final ColorTween? longPressRippleColorTween;
  
  /// background color behind ripple effect.
  final Color? foregroundColor;

  /// background color tween behind ripple effect.
  final ColorTween? foregroundColorTween;


  /// Integrally define whether to use ripple-related effects.
  /// 
  /// * If a value such as a [useTapEffect], [useDoubleTapEffect], [useLongPressEffect]
  ///   is null, it is defined as the [useEffect].
  final bool useEffect;

  /// Whether to use ripple effect when tap
  final bool useTapEffect;

  /// Whether to use ripple effect when double tap
  final bool useDoubleTapEffect;

  /// Whether to use ripple effect when longpress
  final bool useLongPressEffect;

  /// Integrally define whether to use foreground.
  /// 
  /// * If a value such as a [useTapForeground], [useDoubleTapForeground], [useLongPressForeground]
  ///   is null, it is defined as the [useForeground].
  final bool useForeground;

  /// Whether to use foreground when tap
  final bool useTapForeground;

  /// Whether to use foreground when double tap
  final bool useDoubleTapForeground;

  /// Whether to use foreground when longpress
  final bool useLongPressForeground;


  
  /// Integrally define the lower percent of different event types,
  /// Define the minimum spread of the ripple effect as a percent.
  /// 
  /// * If a value such as a [tapLowerPercent], [doubleTapLowerPercent], [longPressLowerPercent]
  ///   is null, it is defined as the [lowerPercent].
  final double lowerPercent;

  /// Integrally define the upper percent of different event types,
  /// Define the maximum spread of the ripple effect as a percent.
  /// 
  /// * If a value such as a [tapUpperPercent], [doubleTapUpperPercent], [longPressUpperPercent]
  ///   is null, it is defined as the [upperPercent].
  final double upperPercent;

  /// The [lowerPercent] of tap ripple effect.
  final double tapLowerPercent;

  /// The [upperPercent] of tap ripple effect.
  final double tapUpperPercent;

  /// The [lowerPercent] of double tap ripple effect.
  final double doubleTapLowerPercent;

  /// The [upperPercent] of double tap ripple effect.
  final double doubleTapUpperPercent;

  /// The [lowerPercent] of longpress ripple effect.
  final double longPressLowerPercent;

  /// The [upperPercent] of longpress ripple effect.
  final double longPressUpperPercent;

  /// The scale of ripple effect size.
  /// 
  /// * Must be greater than zero.
  /// * If you do not want to use an ripple effect define useEffect as false.
  final double scale;

  /// The [scale] of tap effect.
  final double tapScale;

  /// The [scale] of double tap effect.
  final double doubleTapScale;

  /// The [scale] of longpress effect.
  final double longPressScale;

  /// Duration speed scale.
  /// 
  /// * If the [durationScale] is define as 2, all animation duration are defined as double.
  /// * Must be greater than negative number.
  final double durationScale;



  /*
  *   Animations
  */

  /// Spread duration of ripple effect.
  final Duration rippleDuration;

  /// Animation curve of ripple effect,
  /// Curved animation of [rippleDuration].
  final Curve rippleCurve;

  /// Fade in animation of ripple effect.
  /// 
  /// * [rippleColor.alpha] * Fade percent(0 to 1).
  final Duration rippleFadeInDuration;

  /// Animation curve of ripple effect fade in(forward),
  /// Curved animation of [rippleFadeInDuration].
  final Curve rippleFadeInCurve;
  
  /// Fade out animation of ripple effect.
  /// 
  /// * [rippleColor.alpha] * Fade percent(1 to 0).
  final Duration rippleFadeOutDuration;
  
  /// Animation curve of ripple effect fade out(reverse),
  /// Curved animation of [rippleFadeOutDuration].
  final Curve rippleFadeOutCurve;

  /// Fade-out animation duration used when ripple effect
  /// are canceled by [touchSlop] and [RippleOverlapBehavior.cancel].
  final Duration canceledRippleDuration;

  /// Animation curve of canceled ripple effect fade out(reverse),
  /// Curved animation of [canceledRippleDuration].
  final Curve canceledRippleCurve;

  /// Minimum duration to define whether it is tap or longpress
  final Duration longPressDuration;

  /// Animation curve of longpress ripple effect(forward),
  /// Curved animation of [longPressDuration].
  final Curve longPressCurve;

  /// Fade-in animation duration of longpress ripple effect.
  final Duration longPressFadeInDuration;

  /// Animation curve of longpress ripple effect fade in(forward),
  /// Curved animation of [longPressFadeInDuration].
  final Curve longPressFadeInCurve;

  /// Fade-out animation duration of longpress ripple effect.
  final Duration longPressFadeOutDuration;

  /// Animation curve of longpress ripple effect fade out(reverse),
  /// Curved animation of [longPressFadeOutDuration].
  final Curve longPressFadeOutCurve;

  /// Fade-out animation duration of canceled longpress ripple effect.
  final Duration canceledLongPressDuration;

  /// Animation curve of longpress canceled ripple effect fade out(reverse),
  /// Curved animation of [canceledLongPressDuration].
  final Curve canceledLongPressCurve;

  final Duration foregroundFadeInDuration;
  final Curve foregroundFadeInCurve;

  final Duration foregroundFadeOutDuration;
  final Curve foregroundFadeOutCurve;

  final Duration canceledForegroundDuration;
  final Curve canceledForegroundCurve;



  /*
  *   Listener
  */

  /// When one (click or touch).
  /// 
  /// * Use [StartOnEvent] to delay call [onTap].
  final Function onTap;
  
  /// When double (click or touch).
  /// 
  /// * If you have to consider double tap,
  ///   there will be a delay as much as [doubleTapStateDuration].
  final OnDoubleTap? onDoubleTap;

  /// If the double tap has started.
  final Function? onDoubleTapStart;

  /// If the double tap state is canceled.
  /// 
  /// * Called if no event occurs after
  /// [doubleTapStateCancellationDuration] after the double tap is called.
  /// 
  final Function? onDoubleTapEnd;

  /// If the user continues to press for a certain period of time without lifting their hand
  /// 
  /// * Change [longPressDuration] to define
  ///   the minimum duration needed to define if it is a long press.
  final OnLongPress? onLongPress;

  /// Same as [Listener.onHover]
  final Function? onHover;

  /// Same as [MouseRegion.onEnter]
  final Function? onHoverStart;

  /// Same as [MouseRegion.onExit]
  final Function? onHoverEnd;

  /// Same as [Listener.onPointerDown]
  final OnPointer? onPointerDown;

  /// Same as [Listener.onPointerMove]
  final OnPointer? onPointerMove;

  /// Same as [Listener.onPointerUp]
  final OnPointer? onPointerUp;

  /// Same as [Listener.onPointerCancel]
  final OnPointer? onPointerCancel;

  /// Same as [Listener.onPointerCancel]
  final Function? onCancel;



  /// Minimum tapable duration based on pointer down.
  final Duration tapableDuration;

  /// Minimum duration to define whether it is a tap or double tap.
  /// 
  /// * Must be greater than Duration.zero
  final Duration doubleTapStateDuration;

  /// Minimum duration to enter the double tap state and cancel the state.
  /// 
  /// * Must be greater than Duration.zero
  final Duration doubleTapStateCancellationDuration;
  
  /// Pointer down occurs and ripple effects occur only after a certain period of duration.
  /// 
  /// * The value has been declared to define if the gesture is for scrolling or clicking.
  /// * Must be [startTapEffect] is true.
  /// 
  final Duration startTapEffectDuration;


  @override
  State<TouchRipple> createState() => _TouchRippleState();
}

class _TouchRippleState extends State<TouchRipple> with TickerProviderStateMixin {
  /// [Ripple.longpress]
  late AnimationController longPressController = AnimationController(
    vsync: this,
    lowerBound: widget.longPressLowerPercent,
    upperBound: widget.longPressUpperPercent,
  );
  late AnimationController longPressFadeController = AnimationController(
    vsync: this,
    duration: widget.longPressFadeInDuration,
    reverseDuration: widget.longPressFadeOutDuration,
  );
  late CurvedAnimation longPressFadeCurved = CurvedAnimation(
    parent: longPressFadeController,
    curve: widget.longPressFadeInCurve,
    reverseCurve: widget.longPressFadeOutCurve,
  );

  double get longPressPercent => widget.longPressCurve.transform(longPressController.value);
  double get longPressFadePercent => longPressFadeCurved.value;



  /// 사용자가 클릭한 위치를 퍼센트으로 정의합니다.
  Offset centerToRatio = Offset.zero;



  final GlobalKey childKey = GlobalKey();

  /// [widget.child]의 크기 (Size of [widget.child])
  Size get size => _getSize();
  Size _getSize() {
    if(childKey.currentContext == null) return Size.zero;
    
    return (childKey.currentContext?.findRenderObject() as RenderBox).size;
  }



  /// Global key of the [RippleStack]
  final GlobalKey rippleStackKey = GlobalKey();
  
  RippleStackState get rippleStackState => rippleStackKey.currentState as RippleStackState;

  final GlobalKey longPressForegroundKey = GlobalKey();

  RippleForegroundState get longPressForegroundState =>
                            longPressForegroundKey.currentState as RippleForegroundState;



  Offset pointerDownOffset = Offset.zero;
  Offset pointerMoveOffset = Offset.zero;

  Offset get distancePointerOffset => pointerDownOffset - pointerMoveOffset;



  Timer? tapableTimer;

  bool isCanceled = false;
  
  bool isTapable = true;
  
  /// Touch slop에 의해 모든 이벤트를 취소해야 하는 여부
  bool get isMustCancel => distancePointerOffset.dx.abs() > widget.touchSlop ||
                           distancePointerOffset.dy.abs() > widget.touchSlop;



  /// [widget.startTapEffectDuration]
  Timer? startTapEffectTimer;

  /// 이벤트가 탭인지 정의하기 위해 선언된 타이머입니다.
  Timer? tapTimer;

  /// 탭을 한 횟수 또는 [widget.onTap]이 호출된 횟수
  int tapCount = 0;

  /// 연속적으로 더블 탭을 발생시키는지 여부를 정의하기 위해 선언된 타이머입니다.
  Timer? doubleTapTimer;

  /// 더블 탭을 한 횟수 또는 [widget.onDoubleTap]이 호출된 횟수
  int doubleTapCount = 0;

  bool get isDoubleTapStarted => tapCount == 2;
  bool get isDoubleTapState => tapCount > 1;

  /// [startTapEffectTimer]에 의해 정의되는 값입니다.
  bool isVisibleEffect = false;



  /// 사용자가 클릭한 위치를 중심 축에서 떨어진 거리를 퍼센트로 정의합니다.
  /// 
  /// * 맨 오른쪽을 클릭했다면 0.5으로 정의될 것입니다 이는 [widget.child]의 크기를 기준으로 정의하기 때문입니다,
  ///   
  ///   만약 위젯의 크기가 100dp 이고 맨 왼쪽으로 클릭되었다면
  ///   클릭한 위치가 중심 축으로 부터 -50dp 떨어져 있기 때문에 -0.5으로 정의될 것입니다.
  Offset getCenterToRatio(Offset localPosition) {
    double dxCenterToRatio = localPosition.dx / size.width;
    double dyCenterToRatio = localPosition.dy / size.height;

    // 사용자가 위젯의 가운데를 클릭하게 되면 기본적으로 0.5으로 정의될 것입니다.
    // Value -= 0.5 (위젯의 중심축을 기준으로 정의되어야 합니다)
    dxCenterToRatio -= 0.5;
    dyCenterToRatio -= 0.5;

    return Offset(dxCenterToRatio, dyCenterToRatio);
  }



  /// 사용자의 포인터 또는 제스쳐를 인식하여 리플 이벤트와 이펙트를 정의합니다.
  void handlePointer(PointerEvent event) {
    if(!widget.isActive) return;
    
    if(event is PointerDownEvent) {
      isCanceled = false;
      isVisibleEffect = false;

      // 포인터 위치를 초기화합니다.
      // 이때 touchSlop으로 인해 동작이 취소되지 않도록
      // 포인터 위치 값은 무조건
      // pointerMoveOffset == pointerDownOffset 이어야 합니다.
      pointerDownOffset = event.localPosition;
      pointerMoveOffset = pointerDownOffset;

      // 탭 가능한 시간을 초과하면 탭이 불가능하도록 정의합니다.
      if(widget.tapableDuration != Duration.zero) {
        tapableTimer?.cancel();
        tapableTimer = Timer(widget.tapableDuration, () => isTapable = false);
      }

      // 해당 값을 초기화하는 이유는
      // longPressPercent가 widget.tapLowerPercent 보다 크면
      // longPressPercent가 RippleEffect.lowerPercent 으로 우선적으로 참조됩니다.
      // 이를 방지하기 위해 초반에 정의된 값을 초기화해야 합니다.
      //
      longPressController.value = 0;

      // LongPress 애니메이션을 초기화하고 실행합니다.
      if(widget.onLongPress != null) {
        initDuration();
        initCurve();

        longPressController.forward();
        longPressFadeController.forward();
      } else if(widget.startTapEffect == StartTapRippleEffect.pointerDown) {
        startTapEffectTimer?.cancel();
        startTapEffectTimer = Timer(widget.startTapEffectDuration, () {
          isVisibleEffect = true;

          onTap(notDecided: true);
        });
      }

      setState(() => centerToRatio = getCenterToRatio(event.localPosition));
    } else if(event is PointerMoveEvent) {
      pointerMoveOffset = event.localPosition;

      if(isMustCancel && !isCanceled) {
        cancel();

        rippleStackState.cancel();
      }
    } else if(event is PointerUpEvent) {
      tapableTimer?.cancel();
      startTapEffectTimer?.cancel();

      if(isVisibleEffect) { rippleStackState.decided(); return; }

      if(isMustCancel || !isTapable || isCanceled) { cancel(); return; } cancel();

      // 더블 탭인지에 대한 여부를 정의합니다.
      //
      // 만약 정의해야 한다면 widget.doubleTapDuration를 참조하고
      // 그 이상 PointerUp 이벤트가 발생하지 않는다면 탭으로 정의합니다.
      if(widget.onDoubleTap == null) {
        // 더블 탭 여부를 정의하지 않아도 됩니다.
        onTap();
      } else {
        // 더블 탭 여부를 정의해야 합니다.
        tapCount++;

        if(isDoubleTapState) {
          if(isDoubleTapStarted && widget.onDoubleTapStart != null) widget.onDoubleTapStart!();

          // 초기화하기 위해 타이머를 취소합니다.
          tapTimer?.cancel();
          doubleTapTimer?.cancel();
          
          // 연속적으로 더블 탭을 발생할 수 있는지
          if(widget.doubleTapBehavior == DoubleTapBehavior.cancel) {
            initAllCount();
          } else {
            // 사용자가 연속적으로 더블 탭을 발생시키는지 정의하기 위해 타이머를 초기화합니다.
            // 해당 타이머가 계속 초기화된다면 콜백 함수가 호출되지 않고 doubleTapState로 계속 유지 될 것입니다.
            //
            // 해당 콜백 함수가 호출되고 어떠한 이벤트인지 정의하기 위해 선언된 값은 모두 초기화되야 합니다.
            doubleTapTimer = Timer(widget.doubleTapStateCancellationDuration, () {
              initAllCount();

              if(widget.onDoubleTapEnd != null) widget.onDoubleTapEnd!();
            });
          }

          onDoubleTap();
        } else {
          tapTimer = Timer(widget.doubleTapStateDuration, () {
            tapCount = 0;

            onTap();
          });
        }
      }
    } else if(event is PointerCancelEvent) {
      cancel();
    }
  }



  void cancel() {
    startTapEffectTimer?.cancel();

    isTapable = true;
    isCanceled = true;

    longPressController.stop();

    longPressFadeController.reverseDuration = widget.canceledLongPressDuration;
    longPressFadeCurved.reverseCurve = widget.canceledLongPressCurve;
    longPressFadeController.reverse();

    longPressForegroundState.cancel();
  }


  
  void initAllCount() {
    if(widget.onCancel != null) widget.onCancel!();

    doubleTapCount = 0;
    tapCount = 0;
  }



  void onTap({bool notDecided = false}) {
    if(!widget.useTapEffect) return;

    if(widget.useTapEffect) {
      double lowerPercent =
             widget.tapLowerPercent < longPressPercent
           ? longPressPercent
           : widget.tapLowerPercent;

      addRippleEffect(
        overlapBehavior: widget.tapOverlapBehavior,
        lowerPercent: lowerPercent,
        upperPercent: widget.tapUpperPercent,
        startOnEvent: widget.startOnTap,
        onClick: widget.onTap,
        isNotDecided: notDecided,
      );

      if(widget.useTapForeground) rippleStackState.forwardForeground(widget.rippleDuration);
    }
  }

  void onDoubleTap() {
    doubleTapCount++;

    if(widget.useDoubleTapEffect) {
      addRippleEffect(
        overlapBehavior: widget.doubleTapOverlapBehavior,
        lowerPercent: widget.doubleTapLowerPercent,
        upperPercent: widget.doubleTapUpperPercent,
        startOnEvent: widget.startOnDoubleTap,
        onClick: widget.onDoubleTap!,
        isNotDecided: false,
        count: doubleTapCount,
      );

      if(widget.useDoubleTapForeground) {
        rippleStackState.forwardForeground(
          widget.rippleDuration + widget.doubleTapStateCancellationDuration
        );
      }
    }

    if(widget.onDoubleTap != null) {
      bool isRepeatable = widget.onDoubleTap!(doubleTapCount);

      if(!isRepeatable) {
        initAllCount();

        doubleTapTimer?.cancel();
      }
    }
  }

  void addRippleEffect({
    required RippleOverlapBehavior overlapBehavior,
    required double lowerPercent,
    required double upperPercent,
    required StartOnEvent startOnEvent,
    required Function onClick,
    required bool isNotDecided,
    int? count,
  }) {
    if(overlapBehavior == RippleOverlapBehavior.cancel) rippleStackState.cancel();
      
    rippleStackState.add(
      centerToRatio: centerToRatio,
      lowerPercent: lowerPercent,
      upperPercent: upperPercent,
      startOnEvent: startOnEvent,
      onClick: onClick,
      isNotDecided: isNotDecided,
      count: count,
    );
  }



  void initDuration() {
    longPressController.duration = widget.longPressDuration;
    longPressFadeController.duration = widget.longPressFadeInDuration;
    longPressFadeController.reverseDuration = widget.longPressFadeOutDuration;
  }

  void initCurve() {
    longPressFadeCurved.curve = widget.longPressFadeInCurve;
    longPressFadeCurved.reverseCurve = widget.longPressFadeOutCurve;
  }

  void initController() {
    longPressController.addListener(() => setState(() {
      /// longPress으로 정의되고 효과를 페이드 아웃합니다.
      if(longPressController.isCompleted) {
        isCanceled = true;
        longPressFadeController.reverse();

        if(widget.onLongPress != null) widget.onLongPress!();
      }
    }));

    longPressFadeController.addListener(() => setState(() {
      if(widget.longPressBehavior != LongPressBehavior.cancel
      && longPressFadePercent == 0
      && longPressController.isCompleted) {

        longPressController.forward();
        longPressFadeController.forward();
      }
    }));
  }



  @override
  void initState() {
    super.initState();

    initDuration();
    initCurve();
    initController();
  }

  @override
  void dispose() {
    longPressController.dispose();
    longPressFadeController.dispose();
    longPressFadeCurved.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TouchRipple oldWidget) {
    super.didUpdateWidget(oldWidget);

    initDuration();
    initCurve();

    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    Color longPressRippleColor = widget.longPressRippleColor ?? widget.rippleColor;

    Color activeLongPressRippleColor =
          widget.longPressRippleColorTween != null
        ? widget.longPressRippleColorTween!.lerp(longPressPercent)! // true
        : longPressRippleColor;                                     // false

    Color activeForegroundColor =
          widget.foregroundColor != null
        ? widget.foregroundColor!                                       // true
        : widget.rippleColor.withAlpha(widget.rippleColor.alpha ~/ 2);  // false

    if(size == Size.zero) WidgetsBinding.instance.addPostFrameCallback((timeStamp) => setState(() {}));
    
    return ClipRRect(
      clipBehavior: widget.clipBehavior,
      borderRadius: widget.borderRadius,
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (event) {
          if(widget.onPointerDown != null) widget.onPointerDown!(event);

          handlePointer(event);
        },
        onPointerMove: (event) {
          if(widget.onPointerMove != null) widget.onPointerMove!(event);

          handlePointer(event);
        },
        onPointerUp: (event) {
          if(widget.onPointerUp != null) widget.onPointerUp!(event);

          handlePointer(event);
        },
        onPointerHover: (event) { if(widget.onHover != null) widget.onHover!(event); },
        onPointerCancel: (event) {
          if(widget.onPointerCancel != null) widget.onPointerCancel!(event);

          handlePointer(event);
        },
        child: MouseRegion(
          cursor: widget.cursor ?? MouseCursor.defer,
          onEnter: (event) { if(widget.onHoverStart != null) widget.onHoverStart!(); },
          onExit: (event) { if(widget.onHoverEnd != null) widget.onHoverEnd!(); },
          child: NotificationListener<SizeChangedLayoutNotification>(
            onNotification: (notification) {
              WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));

              return true;
            },
            child: Stack(
            children: [
              RippleStack(
                key: rippleStackKey,
                size: size,
                rippleDuration: widget.rippleDuration * widget.durationScale,
                rippleCurve: widget.rippleCurve,
                rippleFadeInDuration: widget.rippleFadeInDuration * widget.durationScale,
                rippleFadeInCurve: widget.rippleFadeInCurve,
                rippleFadeOutDuration: widget.rippleFadeOutDuration * widget.durationScale,
                rippleFadeOutCurve: widget.rippleFadeOutCurve,
                canceledRippleDuration: widget.canceledRippleDuration * widget.durationScale,
                canceledRippleCurve: widget.canceledRippleCurve,
                foregroundFadeInDuration: widget.foregroundFadeInDuration * widget.durationScale,
                foregroundFadeInCurve: widget.foregroundFadeInCurve,
                foregroundFadeOutDuration: widget.foregroundFadeOutDuration * widget.durationScale,
                foregroundFadeOutCurve: widget.foregroundFadeOutCurve,
                color: widget.rippleColor,
                colorTween: widget.rippleColorTween,
                foregroundColor: activeForegroundColor,
                foregroundColorTween: widget.foregroundColorTween,
              ),
              Stack(
                children: [
                  RippleForeground(
                    key: longPressForegroundKey,
                    isVisiable: widget.useLongPressForeground
                             && longPressController.isAnimating,
                    size: size,
                    color: activeForegroundColor,
                    fadeInDuration: widget.foregroundFadeInDuration,
                    fadeInCurve: widget.foregroundFadeInCurve,
                    fadeOutDuration: widget.foregroundFadeOutDuration,
                    fadeOutCurve: widget.foregroundFadeOutCurve,
                  ),
                  SizeChangedLayoutNotifier(
                    child: CustomPaint(
                      key: childKey,
                      painter: RipplePainter(
                        centerToRatio: centerToRatio,
                        radius: BorderRadius.zero,
                        color: activeLongPressRippleColor.withAlpha(
                          (activeLongPressRippleColor.alpha * longPressFadePercent).toInt()
                        ),
                        percent: longPressPercent,
                      ),
                      child: widget.child,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}