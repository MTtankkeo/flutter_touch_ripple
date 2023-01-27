import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/components/start_on_event.dart';
import 'package:flutter_touch_ripple/widgets/ripple_effect.dart';
import 'package:flutter_touch_ripple/widgets/ripple_foreground.dart';



class RippleStack extends StatefulWidget {
  const RippleStack({
    super.key,
    required this.size,
    required this.rippleDuration,
    required this.rippleCurve,
    required this.rippleFadeInDuration,
    required this.rippleFadeInCurve,
    required this.rippleFadeOutDuration,
    required this.rippleFadeOutCurve,
    required this.canceledRippleDuration,
    required this.canceledRippleCurve,
    required this.foregroundFadeInDuration,
    required this.foregroundFadeInCurve,
    required this.foregroundFadeOutDuration,
    required this.foregroundFadeOutCurve,

    required this.color,
    required this.colorTween,
    required this.foregroundColor,
    required this.foregroundColorTween,
  });

  /// The [size] is size of [Ripple.child]
  final Size size;

  final Duration rippleDuration;
  final Curve rippleCurve;

  final Duration rippleFadeInDuration;
  final Curve rippleFadeInCurve;
  
  final Duration rippleFadeOutDuration;
  final Curve rippleFadeOutCurve;

  final Duration canceledRippleDuration;
  final Curve canceledRippleCurve;

  final Duration foregroundFadeInDuration;
  final Curve foregroundFadeInCurve;

  final Duration foregroundFadeOutDuration;
  final Curve foregroundFadeOutCurve;



  /// The [color] is color of [RippleEffect.color]
  final Color color;

  /// Same as [Ripple.colorTween]
  final ColorTween? colorTween;

  /// The [foregroundColor] is ripple foreground background color
  final Color foregroundColor;

  /// The [foregroundColor] is ripple foreground background color tween
  final ColorTween? foregroundColorTween;

  @override
  State<RippleStack> createState() => RippleStackState();
}

class RippleStackState extends State<RippleStack> {

  Timer? foregroundTimer;
  bool isVisiableForeground = false;



  List<GlobalKey> keyList = [];
  List<Widget> children = [];



  bool isDispose = false;



  void add({
    required Offset centerToRatio,
    required double lowerPercent,
    required double upperPercent,
    required StartOnEvent startOnEvent,
    required Function onClick,
    required bool isNotDecided,
    int? count,
    void Function(dynamic value)? onReturn,
  }) {
    final GlobalKey key = GlobalKey();

    keyList.add(key);

    setState(() =>
      children.add(
        RippleEffect(
          key: key,
          count: count,
          centerToRatio: centerToRatio,
          size: widget.size,
          onClick: onClick,
          onReturn: onReturn,
          isNotDecided: isNotDecided,
          startOnEvent: startOnEvent,
          duration: widget.rippleDuration,
          curve: widget.rippleCurve,
          fadeInDuration: widget.rippleFadeInDuration,
          fadeInCurve: widget.rippleFadeInCurve,
          fadeOutDuration: widget.rippleFadeOutDuration,
          fadeOutCurve: widget.rippleFadeOutCurve,
          canceledDuration: widget.canceledRippleDuration,
          canceledCurve: widget.canceledRippleCurve,
          color: widget.color,
          colorTween: widget.colorTween,
          lowerPercent: lowerPercent,
          upperPercent: upperPercent,
        ),
      ),
    );
  }

  void forwardForeground(Duration duration) {
    if(isDispose) return;
    
    setState(() => isVisiableForeground = true);

    foregroundTimer?.cancel();
    foregroundTimer = Timer(duration, () {
      setState(() => isVisiableForeground = false);
    });
  }

  void cancel() {
    if(isDispose) return;

    for(GlobalKey key in keyList) {
      if(key.currentContext == null) continue;

      (key.currentState as RippleEffectState).cancel();
    }
  }

  void decided() {
    if(keyList.last.currentState == null || isDispose) return;

    (keyList.last.currentState as RippleEffectState).decided();
  }



  @override
  void dispose() {
    super.dispose();

    isDispose = true;
  }

  @override
  void deactivate() {
    super.deactivate();

    isDispose = false;
  }



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: Stack(
        children: [
          RippleForeground(
            isVisiable: isVisiableForeground,
            size: widget.size,
            color: widget.foregroundColor,
            fadeInDuration: widget.foregroundFadeInDuration,
            fadeInCurve: widget.rippleFadeInCurve,
            fadeOutDuration: widget.foregroundFadeOutDuration,
            fadeOutCurve: widget.foregroundFadeOutCurve,
          ),
          Stack(children: children),
        ],
      ),
    );
  }
}