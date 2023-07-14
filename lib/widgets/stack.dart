import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/components/controller.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:flutter_touch_ripple/widgets/render.dart';




/// This is a widget that is declared to manage, add or remove touch effect animations.
class TouchRippleStack extends StatefulWidget {
  const TouchRippleStack({
    super.key,
    required this.child,
    required this.renderOrder,
    required this.rippleColor,
    required this.rippleScale,
    required this.borderRadius,
    required this.controller,
  });

  /// The [child] widget contained by the [TouchRippleStack] widget.
  /// 
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// Same as [TouchRippleWidget.renderOrder].
  final TouchRippleRenderOrderType renderOrder;

  /// Same as [TouchRippleWidget.rippleColor].
  final Color rippleColor;

  /// Same as [TouchRippleWidget.rippleScale].
  final double rippleScale;

  /// Same as [TouchRippleWidget.borderRadius].
  final BorderRadius borderRadius;

  /// Same as [TouchRippleWidget.controller].
  final TouchRippleController controller;
  
  @override
  State<TouchRippleStack> createState() => _TouchRippleStackState();
}

class _TouchRippleStackState extends State<TouchRippleStack> with TickerProviderStateMixin {

  void onUpdated() {
    setState(() {
      // The defined touch ripple state updates to update the state of the widget.
    });
  }

  @override
  void initState() {
    super.initState();

    widget.controller.vsync = this;
    widget.controller.addListener(onUpdated);
  }

  @override
  void activate() {
    super.activate();

    widget.controller.addListener(onUpdated);
  }

  @override
  void deactivate() {
    super.deactivate();

    widget.controller.removeListener(onUpdated);
  }

  @override
  Widget build(BuildContext context) {
    CustomPainter? backgroundPainter;
    CustomPainter? foregroundPainter;

    final painter = TouchRipplePainter(
      states: widget.controller.paints,
      color: widget.rippleColor,
      scale: widget.rippleScale,
      borderRadius: widget.borderRadius,
    );

    if (widget.renderOrder  == TouchRippleRenderOrderType.background) {
      backgroundPainter = painter;
    } else {
      foregroundPainter = painter;
    }

    return CustomPaint(
      foregroundPainter: foregroundPainter,
      painter: backgroundPainter,
      child: widget.child,
    );
  }
}