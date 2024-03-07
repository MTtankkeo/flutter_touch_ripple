import 'package:flutter/foundation.dart';
import 'package:flutter_touch_ripple/components/effect.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

/// Used by [TouchRipple].
class TouchRippleController extends Listenable {
  final List<TouchEffect> _effects = <TouchEffect>[];
  final ObserverList<VoidCallback> _listeners = ObserverList<VoidCallback>();

  @override
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void attach(TouchEffect effect) {
    // TODO: After developing all TouchEffect.
  }

  void detach(TouchEffect effect) {
    // TODO: After developing all TouchEffect.
  }

  /// Merges the effects of the given touch-ripple controller.
  void merge(TouchRippleController author) {
    _effects.addAll(author._effects);
  }

  @override
  String toString() => "TouchRippleController()";
}