import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/style.dart';

mixin TouchRippleContext {
  TickerProvider get vsync;
  TouchRippleStyle get style;
}