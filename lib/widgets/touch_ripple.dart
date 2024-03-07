import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/controller.dart';
import 'package:flutter_touch_ripple/widgets/render_touch_ripple.dart';

class TouchRipple extends StatefulWidget {
  const TouchRipple({
    super.key,
    required this.child,
    this.onTap,
    this.controller,
  });

  /// This widget to which the touch effects will be applied.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// Called when a user taps or clicks on a widget.
  final VoidCallback? onTap;

  final TouchRippleController? controller;

  @override
  State<TouchRipple> createState() => _TouchRippleState();
}

class _TouchRippleState extends State<TouchRipple> {
  late TouchRippleController _controller = widget.controller ?? TouchRippleController();

  @override
  void didUpdateWidget(covariant TouchRipple oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// When the touch-ripple controller changes.
    if (widget.controller != null
    && (widget.controller != _controller)) {
      _controller = widget.controller!..merge(_controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RenderTouchRipple(controller: _controller, child: widget.child);
  }
}