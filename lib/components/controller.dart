import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_touch_ripple/components/behavior.dart';
import 'package:flutter_touch_ripple/components/states.dart';





class TouchRippleController extends Listenable {
  /// Defines whether to disable the focus effect when in a hover state.
  bool? _isOnHoveredDisableFocusEffect;
  bool get isOnHoveredDisableFocusEffect {
    assert(
      _isOnHoveredDisableFocusEffect != null,
      'A required setting value was not initialised on the controller.'
    );
    return _isOnHoveredDisableFocusEffect ?? true;
  }
  set isOnHoveredDisableFocusEffect(bool newValue) {
    _isOnHoveredDisableFocusEffect = newValue;
  }

  TouchRippleBackgroundState? _hoverState;
  TouchRippleBackgroundState? get hoverState => _hoverState;
  set hoverState(TouchRippleBackgroundState? newState) {
    _hoverState = newState?..addListener(notifyListeners);
  }

  TouchRippleBackgroundState? _focusState;
  TouchRippleBackgroundState? get focusState => _focusState;
  set focusState(TouchRippleBackgroundState? newState) {
    _focusState = newState?..addListener(notifyListeners);
  }

  late final List<TouchRippleState> rippleStates = <TouchRippleState>[];

  List<TouchRipplePaintable> get paints {
    final paints = <TouchRipplePaintable>[];
    if (_hoverState != null) paints.add(_hoverState!);
    if (_focusState != null && (_hoverState == null || !isOnHoveredDisableFocusEffect)) {
      paints.add(_focusState!);
    }
    paints.addAll(rippleStates);

    return paints;
  }

  late final TickerProvider vsync;

  late final ObserverList<VoidCallback> _listeners = ObserverList<VoidCallback>();
  
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

  void pasteWith(TouchRippleController controller) {
    hoverState = controller.hoverState;

    rippleStates.clear();
    rippleStates.addAll(controller.rippleStates);
  }
  
  void attach(TouchRippleState state) {
    assert(!rippleStates.contains(state));
    rippleStates.add(state..addListener(notifyListeners));
  }

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

  // ignore: avoid_function_literals_in_foreach_calls
  void notifyListeners() => _listeners.forEach((e) => e.call());
}