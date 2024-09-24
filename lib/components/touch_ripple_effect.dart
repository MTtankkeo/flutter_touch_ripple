import 'package:flutter/material.dart';

abstract class TouchRippleEffect extends Listenable {
  /// Called when after the touch ripple effect has fully completed
  /// and the relevant instances have been cleaned up.
  VoidCallback? onDispose;

  draw(Canvas canvas, Size size);
}