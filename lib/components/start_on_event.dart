


/// A Class declared for definition of when to call ontap.
class StartOnEvent {
  /// Whether to hold the call of the [Ripple.onTap] callback function
  final bool isWait;

  /// If the ripple effect spreads more than [percent], call the [Ripple.onTap] callback function.
  final double percent;

  const StartOnEvent({
    required this.isWait,
    this.percent = 1,
  }) : assert(!(percent > 1 || percent < 0), 'The value from is 0.0 to 1.0');
}