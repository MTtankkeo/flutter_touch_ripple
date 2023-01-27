import 'package:flutter/material.dart';



class RippleForeground extends StatefulWidget {
  const RippleForeground({
    super.key,
    required this.isVisiable,
    required this.size,
    required this.color,
    required this.fadeInDuration,
    required this.fadeInCurve,
    required this.fadeOutDuration,
    required this.fadeOutCurve,
  });

  final bool isVisiable;

  final Size size;
  final Color color;

  final Duration fadeInDuration;
  final Curve fadeInCurve;

  final Duration fadeOutDuration;
  final Curve fadeOutCurve;

  @override
  State<RippleForeground> createState() => RippleForegroundState();
}



class RippleForegroundState extends State<RippleForeground> with TickerProviderStateMixin {
  late AnimationController foregroundController = AnimationController(vsync: this);
  late CurvedAnimation foregroundCurved = CurvedAnimation(
    parent: foregroundController,
    curve: widget.fadeInCurve,
    reverseCurve: widget.fadeOutCurve,
  );

  get foregroundFadePercent => foregroundCurved.value;



  void initAnimationController() {
    foregroundController.addListener(() => setState(() {}));
  }

  void initDuration() {
    foregroundController.duration = widget.fadeInDuration;
    foregroundController.reverseDuration = widget.fadeOutDuration;
  }

  void initCurve() {
    foregroundCurved.curve = widget.fadeInCurve;
    foregroundCurved.reverseCurve = widget.fadeOutCurve;
  }

  void cancel() {
    foregroundController.stop();
    foregroundController.value = 0;
  }



  @override
  void initState() {
    super.initState();

    initDuration();
    initCurve();
    initAnimationController();
  }

  @override
  void didUpdateWidget(covariant RippleForeground oldWidget) {
    super.didUpdateWidget(oldWidget);

    initDuration();
    initCurve();

    widget.isVisiable ?
    foregroundController.forward() :  // true
    foregroundController.reverse();   // false
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: widget.size.height,
      color: widget.color.withAlpha(
        (widget.color.alpha * foregroundFadePercent).toInt()
      ),
    );
  }
}