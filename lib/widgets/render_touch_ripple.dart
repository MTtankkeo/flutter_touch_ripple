import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/controller.dart';

class RenderTouchRipple extends StatelessWidget {
  const RenderTouchRipple({
    super.key,
    required this.controller,
    required this.child,
  });

  final TouchRippleController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return child;
      },
    );
  }
}