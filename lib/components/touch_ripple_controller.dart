import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

/// Signature for the function that is called when the touch ripple effect is
/// added or when the state of the touch ripple controller changes.
typedef TouchRippleListener = VoidCallback;

/// The class efines and manages states, listeners, a context and other values related
/// to touch ripple, ensuring that each state exists uniquely within the controller. 
/// 
/// See Also, An instance of this class can be referenced and accessed
/// externally to attach or detach states or related values.
class TouchRippleController extends Listenable {
  late final TouchRippleContext context;

  /// The list defines the listeners for a touch ripple state related.
  final _listeners = ObserverList<TouchRippleListener>();

  /// The list defines the instances of the [TouchRippleEffect].
  final _states = <TouchRippleEffect>[];

  /// The hash map defines a mapping of touch ripple effects by their keys 
  /// to allow referencing specific instances of [TouchRippleEffect] that 
  /// are not disposed of when their states change.
  final _stateMap = HashMap<String, TouchRippleEffect>();

  /// Returns all the current touch ripple effects that are attached 
  /// and active to this touch ripple controller as a list.
  List<TouchRippleEffect> get activeEffects {
    final statesFromMap = _stateMap.entries.map((entry) => entry.value);
    return [...statesFromMap, ..._states];
  }

  /// Delegates the task of adding a touch ripple effect to this controller
  /// to ensure it can be reliably detached and disposed later./
  attach(TouchRippleEffect effect) {
    if (context.overlapBehavior == TouchRippleOverlapBehavior.ignore && _states.isNotEmpty) return;
    if (context.overlapBehavior == TouchRippleOverlapBehavior.cancel) {
      _states.whereType<TouchRippleSpreadingEffect>().toList().forEach((effect) => effect.cancel());
    }

    effect.addListener(notifyListeners);
    effect.isAttached = true;
    effect.onDispose = () => detach(effect);

    assert(!_states.contains(effect), "Already exists a given ripple effect.");
    _states.add(effect);
  }

  /// Delegates the task of detaching and disposing of a touch ripple effect
  /// to ensure consistency with [attach] function.
  detach(TouchRippleEffect effect) {
    assert(_states.contains(effect), "Already not exists a given ripple effect.");
    _states.remove(effect..removeListener(notifyListeners));
  }

  /// Delegates the task of adding a touch ripple effect to this controller
  /// to ensure it can be reliably detached and disposed late by a given key.
  attachByKey(String key, TouchRippleEffect effect) {
    assert(!_stateMap.containsKey(key), "Already exists a given ripple effect");
    _stateMap[key] = effect
      ..addListener(notifyListeners)
      ..onDispose = () => detachByKey(key);
  }

  /// Delegates the task of detaching and disposing of a touch ripple effect
  /// to ensure consistency with [attachByKey] function by a given key.
  detachByKey(String key) {
    assert(_stateMap.containsKey(key), "Already not exists a given ripple effect.");
    _stateMap.remove(key)?..removeListener(notifyListeners);
  }

  /// Returns the ripple effect instance corresponding a given key.
  TouchRippleEffect? getEffectByKey(String key) {
    return _stateMap[key];
  }

  /// Delegates all states and context from a given controller to itself and removes
  /// all states from the given controller, ensuring that each state exists only
  /// once in the controller.
  delegateFrom(TouchRippleController other) {
    _states.clear();
    _states.addAll(other._states..clear());
    _stateMap.clear();
    _stateMap.addAll(other._stateMap..clear());
    context = other.context;
  }

  @override
  void addListener(VoidCallback listener) {
    assert(!_listeners.contains(listener), "Already exists a given listener.");
    _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    assert(_listeners.contains(listener), "Already not exists a given listener.");
    _listeners.remove(listener);
  }

  /// Notifies that the state related to the controller has changed.
  void notifyListeners() => _listeners.forEach((l) => l.call());

  /// Disposes all instances related the controller(e.g. [TouchRippleEffect]).
  dispose() {
    _states.toList().forEach((state) => state.dispose());
    _stateMap.forEach((_, state) => state.dispose());
    _stateMap.clear();
  }
}