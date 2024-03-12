import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/effect.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple_context.dart';

/// Controls a touch-ripple widget.
/// 
/// Touch-ripple controllers are typically stored as member variables in [State]
/// objects and are reused in each [State.build].
/// 
/// Used by [TouchRipple].
class TouchRippleController extends Listenable {
  final List<TouchEffect> _effects = <TouchEffect>[];
  final ObserverList<VoidCallback> _listeners = ObserverList<VoidCallback>();
  
  set context(TouchRippleContext context) {
    assert(_context == null, "A touch-ripple context has already been initialized.");
    _context = context;
  }
  TouchRippleContext? _context;
  TouchRippleContext get context {
    assert(_context != null, "");
    return _context!;
  }

  TouchEffect createRippleEffect(VoidCallback callback, TouchRippleBehvaior behvaior) {
    return TouchRippleEffect();
  }

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
    _context = author._context;
    _effects.addAll(author._effects);
  }

  @override
  String toString() => "TouchRippleController()";
}