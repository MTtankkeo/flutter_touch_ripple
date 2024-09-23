import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

/// Signature for the function that is called when the touch ripple effect is
/// added or when the state of the touch ripple controller changes.
typedef TouchRippleListener = int Function();

/// Defines and manages states, listeners, a context and other values related to
/// touch ripple, ensuring that each state exists uniquely within the controller. 
/// 
/// See Also, An instance of this class can be referenced and accessed
/// externally to attach or detach states or related values.
/// 
class TouchRippleController {
  late final TouchRippleContext context;

  /// This list defines the value for a state that represents a touch ripple effect.
  final List<TouchRippleState> _states = [];

  /// Delegates all states from a given controller to itself and removes all states from
  /// the given controller, ensuring that each state exists only once in the controller.
  delegateFrom(TouchRippleController other) {
    _states.clear();
    _states.addAll(other._states..clear());
  }
}