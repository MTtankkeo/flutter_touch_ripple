import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/components/start_on_event.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';



class RippleEffect extends StatefulWidget {
  const RippleEffect({
    super.key,
    required this.count,
    required this.startOnEvent,
    required this.onClick,
    this.onReturn,
    required this.isNotDecided,
    required this.centerToRatio,
    required this.size,
    required this.duration,
    required this.curve,
    required this.fadeInDuration,
    required this.fadeInCurve,
    required this.fadeOutDuration,
    required this.fadeOutCurve,
    required this.canceledDuration,
    required this.canceledCurve,

    required this.color,
    required this.colorTween,
    required this.lowerPercent,
    required this.upperPercent,
    required this.radius,
  });

  final int? count;

  final Offset centerToRatio;

  final Size size;

  final StartOnEvent startOnEvent;
  final Function onClick;
  final void Function(dynamic value)? onReturn;

  final bool isNotDecided;

  final Duration duration;
  final Curve curve;

  final Duration fadeInDuration;
  final Curve fadeInCurve;
  
  final Duration fadeOutDuration;
  final Curve fadeOutCurve;

  final Duration canceledDuration;
  final Curve canceledCurve;



  /// The [color] is color of ripple effect
  final Color color;

  /// Same as [Ripple.colorTween]
  final ColorTween? colorTween;

  /// Same as [Ripple.lowerPercent]
  final double lowerPercent;

  /// Same as [Ripple.upperPercent]
  final double upperPercent;

  final BorderRadius radius;

  @override
  State<RippleEffect> createState() => RippleEffectState();
}

class RippleEffectState extends State<RippleEffect> with TickerProviderStateMixin {
  late AnimationController rippleController = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  late AnimationController fadeController = AnimationController(
    vsync: this,
    duration: widget.fadeInDuration,
    reverseDuration: widget.fadeOutDuration,
  );

  late CurvedAnimation fadeCurved = CurvedAnimation(
    parent: fadeController,
    curve: widget.fadeInCurve,
    reverseCurve: widget.fadeOutCurve,
  );



  double get ripplePercent => widget.curve.transform(rippleController.value);
  double get fadePercent => fadeCurved.value;



  bool isDispose = false;
  bool isNotDecided = false;
  bool isCalled = false;



  void initAnimationController() {
    rippleController.addListener(() => setState(() {
      if(rippleController.isCompleted && !isNotDecided) {
        fadeController.reverse();
      }

      double callablePercent =
             widget.startOnEvent.isWait == false
           ? 0                                    // true
           : widget.startOnEvent.percent;         // false

      if(ripplePercent >= callablePercent && !isCalled && !isNotDecided) {
        onClick();
      }
    }));
    
    fadeController.addListener(() => setState(() {
      if(fadePercent == 0) dispose();
    }));
  }



  void onClick() {
    if(widget.count != null) {
      dynamic value = widget.onClick(widget.count);

      if(widget.onReturn != null) widget.onReturn!(value);
    } else {
      dynamic value = widget.onClick();
      
      if(widget.onReturn != null) widget.onReturn!(value);
    }

    isCalled = true;
  }
  
  void cancel() {
    if(isDispose) return;

    fadeController.reverseDuration = widget.canceledDuration;
    fadeCurved.reverseCurve = widget.canceledCurve;

    fadeController.reverse();
  }

  void decided() {
    if(isDispose) return;

    isNotDecided = false;

    if(rippleController.isCompleted) {
      onClick();

      fadeController.reverse();
    }
  }



  void initDuration() {
    fadeController.duration = widget.fadeInDuration;
    fadeController.reverseDuration = widget.fadeOutDuration;
  }



  @override
  void initState() {
    super.initState();

    isNotDecided = widget.isNotDecided;

    initDuration();
    initAnimationController();

    rippleController.forward();
    fadeController.forward();
  }

  @override
  void dispose() {
    if(isDispose) return;

    rippleController.dispose();

    fadeController.dispose();
    fadeCurved.dispose();

    super.dispose();

    isDispose = true;
  }

  @override
  Widget build(BuildContext context) {
    double maxPercent = widget.upperPercent - widget.lowerPercent;
    double formPercent = widget.lowerPercent + (maxPercent * ripplePercent);

    Color activeColor =
          widget.colorTween != null
        ? widget.colorTween!.lerp(ripplePercent)! // true
        : widget.color;                           // false

    return CustomPaint(
      size: Size(widget.size.width, widget.size.height),
      painter: RipplePainter(
        centerToRatio: widget.centerToRatio,
        radius: widget.radius,
        color: activeColor.withAlpha((activeColor.alpha * fadePercent).toInt()),
        percent: formPercent,
      ),
    );
  }
}