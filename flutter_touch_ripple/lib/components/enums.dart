


/// The behavior on what events occur and forward ripple effect.
enum StartTapRippleEffect {
  pointerDown,
  pointerUp,
}



/// The behavior when double tabs occur continuously.
enum DoubleTapBehavior {
  repeatable,
  cancel,
}



/// The behavior is define whether longpress can occur continuously.
enum LongPressBehavior {
  repeatable,
  cancel,
}



/// The behavior when a ripple effect needs to be displayed when the ripple effect is not complete.
enum RippleOverlapBehavior {
  /// Covers new ripple effects without cancel previous ripple effects.
  overlap,
  /// Cancel the previous ripple effect and display the new ripple effect.
  cancel,
}