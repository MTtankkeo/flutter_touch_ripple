import 'package:flutter/material.dart';





class TouchRippleGestureDelegator extends StatefulWidget {
  const TouchRippleGestureDelegator({
    super.key,
    required this.child,
  });

  /// The [child] widget contained by the [TouchRippleGestureDelegator] widget.
  /// 
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  @override
  State<TouchRippleGestureDelegator> createState() => _TouchRippleGestureDelegatorState();
}

class _TouchRippleGestureDelegatorState extends State<TouchRippleGestureDelegator> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}