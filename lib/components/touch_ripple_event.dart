
class TouchRippleEvent {
  const TouchRippleEvent({
    required this.x,
    required this.y
  }) : assert(x >= 0 && x <= 1, "This value must be from 0 to 1 or between."),
       assert(y >= 0 && y <= 1, "This value must be from 0 to 1 or between.");

  final double x;
  final double y;
}