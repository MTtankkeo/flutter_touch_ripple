import 'package:flutter/material.dart';

/// This inherited widget globally provides the style information for touch ripple
/// effects to all descendant widgets in the widget tree.
class TouchRippleStyle extends InheritedWidget {
  const TouchRippleStyle({
    super.key,
    required super.child,
    this.rippleColor,
    this.hoverColor,
  });

  /// This value defines the background color of the spread ripple effect.
  final Color? rippleColor;

  /// This value defines the background color of the effect when the user hovers.
  final Color? hoverColor;

  @override
  bool updateShouldNotify(TouchRippleStyle oldWidget) {
    return rippleColor != oldWidget.rippleColor
        || hoverColor != oldWidget.hoverColor;
  }
}