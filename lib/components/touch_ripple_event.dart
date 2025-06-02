import 'package:flutter/animation.dart';

/// Signature for the callback function that is called when a touch ripple effect
/// is triggered. The [offset] parameter provides the position of the touch
/// event relative to a widget coordinate system.
typedef TouchRippleCallback = void Function(Offset offset);

/// Signature for the function that returns a Future of type [T]
/// that represents the data type returned asynchronously.
typedef TouchRippleAsyncCallback<T> = Future<T> Function();

/// Signature for the function that indicates the start of an asynchronous operation.
/// It includes a parameter to provide the associated Future instance.
typedef TouchRippleAsyncNotifyCallback<T> = void Function(Future<T> data);

/// Signature for the function that takes a parameter of type [T]
/// that represents the result of an asynchronous operation,
/// passed to the function when the operation is completed.
typedef TouchRippleAsyncResultCallback<T> = void Function(T result);

/// Signature for the callback function that is called to determine
/// whether a continuable touch ripple event should continue.
/// 
/// The [count] parameter indicates how many times the event has occurred
/// consecutively, and the returned [bool] specifies whether
/// the continuable touch ripple event should continue.
typedef TouchRippleContinuableCallback = bool Function(int count);

/// Signature for the callback function that is called when a consecutive
/// touch ripple event occurs, combining both the behavior of
/// [TouchRippleCallback] and [TouchRippleContinuableCallback].
/// 
/// The [offset] parameter provides the position of the touch event relative to
/// the widget coordinate system, and the [count] parameter indicates how many
/// times the event has occurred consecutively. The returned [bool] specifies
/// whether the event should continue after the consecutive occurrence.
typedef TouchRippleConsecutiveCallback = bool Function(Offset offset, int count);

/// Signature for the callback function that is called when the user drags  
/// horizontally(e.g. left, right) or vertically(e.g. top, bottom) and the
/// gesture event is accepted.
///
/// The [delta] parameter represents the distance dragged by the user.
typedef TouchRippleDragCallback = void Function(double delta);