import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/behavior.dart';
import 'package:flutter_touch_ripple/components/states.dart';




mixin TouchRippleBehaviorsMixin {

}

class TouchRippleController extends Listenable {
  /// Defines whether to disable the focus effect when in a hover state.
  bool? _isOnHoveredDisableFocusEffect;

  /// This getter is returns [_isOnHoveredDisableFocusEffect] of
  /// this controller settings value.
  bool get isOnHoveredDisableFocusEffect {
    assert(
      _isOnHoveredDisableFocusEffect != null,
      'A required setting value was not initialised on the controller.'
    );
    return _isOnHoveredDisableFocusEffect ?? true;
  }
  /// This setter is initialise [_isOnHoveredDisableFocusEffect] of
  /// this controller settings value.
  set isOnHoveredDisableFocusEffect(bool newValue) {
    _isOnHoveredDisableFocusEffect = newValue;
  }

  /// Defines [TouchRippleBackgroundState] of hover state.
  TouchRippleBackgroundState? _hoverState;

  /// This getter is returns defined hover state with this controller.
  TouchRippleBackgroundState? get hoverState => _hoverState;

  /// This setter is defines hover state of this controller.
  set hoverState(TouchRippleBackgroundState? newState) {
    _hoverState = newState?..addListener(notifyListeners);
  }

  /// Defines [TouchRippleBackgroundState] of focus state.
  TouchRippleBackgroundState? _focusState;

  /// This getter is returns defined focus state with this controller.
  TouchRippleBackgroundState? get focusState => _focusState;

  /// This setter is defines focus state of this controller.
  set focusState(TouchRippleBackgroundState? newState) {
    _focusState = newState?..addListener(notifyListeners);
  }

  /// Defines attached list of [TouchRippleState].
  late final List<TouchRippleState> rippleStates = <TouchRippleState>[];

  /// Returns a list of all actived states.
  List<TouchRipplePaintable> get paints {
    final paints = <TouchRipplePaintable>[];
    if (_hoverState != null) paints.add(_hoverState!);
    if (_focusState != null && (_hoverState == null || !isOnHoveredDisableFocusEffect)) {
      paints.add(_focusState!);
    }
    paints.addAll(rippleStates);

    return paints;
  }

  /// Defines the vsync of [AnimationController] of attached states.
  late final TickerProvider vsync;

  /// Defines the callback function that should be called back
  /// whenever the controller's state updates.
  late final ObserverList<VoidCallback> _listeners = ObserverList<VoidCallback>();
  
  /// Redefine the current defined vsync of this controller.
  void resetVsync(TickerProvider newVsync) => vsync = newVsync;
  
  /// Returns a new instance of [TouchRippleState] corresponding to the given [behavior].
  TouchRippleState createState({
    required TouchRippleBehavior behavior,
    required VoidCallback callback,
    required Offset eventedOffset,
    required bool isRejectable,
  }) {
    return TouchRippleState(
      vsync: vsync,
      behavior: behavior,
      callback: callback,
      onDismissed: dispatch,
      eventedOffset: eventedOffset,
      isRejectable: isRejectable,
    );
  }

  /// Returns a new instance of [TouchRippleBackgroundState] corresponding to the given behaviors.
  TouchRippleBackgroundState createBackgroundState({
    required Color color,
    required Duration fadeInDuration,
    required Curve fadeInCurve,
    required Duration? fadeOutDuration,
    required Curve? fadeOutCurve,
    required VoidCallback onDispatch,
  }) {
    return TouchRippleBackgroundState(
      vsync: vsync,
      color: color,
      fadeInDuration: fadeInDuration,
      fadeInCurve: fadeInCurve,
      fadeOutDuration: fadeOutDuration,
      fadeOutCurve: fadeOutCurve,
      onDismissed: onDispatch,
    );
  }

  /// Delegate the states of a given controller to this controller.
  void pasteWith(TouchRippleController controller) {
    hoverState = controller.hoverState;

    rippleStates.clear();
    rippleStates.addAll(controller.rippleStates);
  }
  
  /// Attach a given touch ripple state with the this controller.
  void attach(TouchRippleState state) {
    assert(!rippleStates.contains(state));
    rippleStates.add(state..addListener(notifyListeners));
  }

  /// Dispatch a given touch ripple state with the this controller.
  void dispatch(TouchRippleState state) {
    assert(rippleStates.contains(state));
    rippleStates.remove(state..removeListener(notifyListeners)..dispose());
  }
  
  @override
  void addListener(VoidCallback listener) {
    assert(!_listeners.contains(listener));
    _listeners.add(listener);
  }
  
  @override
  void removeListener(VoidCallback listener) {
    assert(_listeners.contains(listener));
    _listeners.remove(listener);
  }

  // Callbacks all listeners.
  //
  // ignore: avoid_function_literals_in_foreach_calls
  void notifyListeners() => _listeners.forEach((e) => e.call());
}