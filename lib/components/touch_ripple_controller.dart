import 'package:flutter/foundation.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

/// Signature for the function that is called when the touch ripple effect is
/// added or when the state of the touch ripple controller changes.
typedef TouchRippleListener = VoidCallback;

/// Defines and manages states, listeners, a context and other values related to
/// touch ripple, ensuring that each state exists uniquely within the controller. 
/// 
/// See Also, An instance of this class can be referenced and accessed
/// externally to attach or detach states or related values.
/// 
class TouchRippleController extends Listenable {
  late final TouchRippleContext context;

  /// This list defines the listeners for a touch ripple state related.
  final _listeners = ObserverList<TouchRippleListener>();

  /// This list defines the value for a state that represents a touch ripple effect.
  final List<TouchRippleEffect> _states = [];

  /// Delegates the task of adding a touch ripple effect to this controller
  /// to ensure it can be reliably detached and disposed later.
  attach(TouchRippleEffect effect) {
    assert(!_states.contains(effect), "Already exists a given effect");
    _states.add(effect..addListener(notifyListeners)..onDispose = () => detach(effect));
  }

  /// Delegates the task of detaching and disposing of a touch ripple effect
  /// to ensure consistency with [attach] function.
  detach(TouchRippleEffect effect) {
    assert(_states.contains(effect), "Already not exists a given effect");
    _states.remove(effect..removeListener(notifyListeners));
  }

  /// Delegates all states from a given controller to itself and removes all states from
  /// the given controller, ensuring that each state exists only once in the controller.
  delegateFrom(TouchRippleController other) {
    _states.clear();
    _states.addAll(other._states..clear());
  }

  @override
  void addListener(VoidCallback listener) {
    assert(!_listeners.contains(listener), "Already exists a given listener");
    _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    assert(_listeners.contains(listener), "Already not exists a given listener");
    _listeners.remove(listener);
  }

  notifyListeners() {
    for (final listener in _listeners) {
      listener.call();
    }
  }
}