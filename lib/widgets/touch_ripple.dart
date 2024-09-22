import 'package:flutter/cupertino.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple_connection.dart';

class TouchRipple extends TouchRippleConnection {
  const TouchRipple({
    super.key,
    super.onTap,
    super.onDoubleTap,
    super.onLongTap,
    super.behavior,
    required super.child
  });

  @override
  State<TouchRipple> createState() => _TouchRippleState();
}

class _TouchRippleState extends State<TouchRipple> {
  @override
  Widget build(BuildContext context) {
    return TouchRippleConnection(
      onTap: widget.onTap,
      onDoubleTap: widget.onDoubleTap,
      onLongTap: widget.onLongTap,
      behavior: widget.behavior,
      child: widget.child,
    );
  }
}