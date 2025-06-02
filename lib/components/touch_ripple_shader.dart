import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';

class TouchRippleShader {
  static late final ui.FragmentProgram program;
  static bool initCalled = false;
  static bool isInitialized = false;

  static const double _rotateRight = math.pi * 0.0078125;
  static const double _rotateLeft = -_rotateRight;
  static const double _noiseDensity = 2.1;

  static void initializeShader() {
    if (!initCalled) {
      ui.FragmentProgram.fromAsset('shaders/ink_sparkle.frag').then((ui.FragmentProgram loaded) {
        program = loaded;
        isInitialized = true;
      });
      initCalled = true;
    }
  }

  /// implementation from the following classes about [InkSparkle].
  static void updateFragmentShader({
    required ui.FragmentShader shader,
    required Color color,
    required double alpha,
    required double rippleScale,
    required double rippleAlpha,
    required Offset center,
    required double radius,
    required double blurRatio,
    required Size size,
  }) {
    final double turbulenceSeed = math.Random().nextDouble() * 1000.0;
    const double turbulenceScale = 1.5;
    final double turbulencePhase = turbulenceSeed + rippleScale;
    final double noisePhase = turbulencePhase;
    final double rotation1 = turbulencePhase * _rotateRight + 1.7 * math.pi;
    final double rotation2 = turbulencePhase * _rotateLeft + 2.0 * math.pi;
    final double rotation3 = turbulencePhase * _rotateRight + 2.75 * math.pi;

    shader
      // uColor
      ..setFloat(0, color.red / 255.0)
      ..setFloat(1, color.green / 255.0)
      ..setFloat(2, color.blue / 255.0)
      ..setFloat(3, color.alpha / 255.0)
      // Composite 1 (u_alpha, u_sparkle_alpha, u_blur, u_radius_scale)
      ..setFloat(4, rippleAlpha)
      ..setFloat(5, alpha)
      ..setFloat(6, blurRatio)
      ..setFloat(7, rippleScale)
      // uCenter
      ..setFloat(8, center.dx)
      ..setFloat(9, center.dy)
      // uMaxRadius
      ..setFloat(10, radius)
      // uResolutionScale
      ..setFloat(11, 1.0 / size.width)
      ..setFloat(12, 1.0 / size.height)
      // uNoiseScale
      ..setFloat(13, _noiseDensity / size.width)
      ..setFloat(14, _noiseDensity / size.height)
      // uNoisePhase
      ..setFloat(15, noisePhase / 1000.0)
      // uCircle1
      ..setFloat(16, turbulenceScale * 0.5 + (turbulencePhase * 0.01 * math.cos(turbulenceScale * 0.55)))
      ..setFloat(17, turbulenceScale * 0.5 + (turbulencePhase * 0.01 * math.sin(turbulenceScale * 0.55)))
      // uCircle2
      ..setFloat(18, turbulenceScale * 0.2 + (turbulencePhase * -0.0066 * math.cos(turbulenceScale * 0.45)))
      ..setFloat(19, turbulenceScale * 0.2 + (turbulencePhase * -0.0066 * math.sin(turbulenceScale * 0.45)))
      // uCircle3
      ..setFloat(20, turbulenceScale + (turbulencePhase * -0.0066 * math.cos(turbulenceScale * 0.35)))
      ..setFloat(21, turbulenceScale + (turbulencePhase * -0.0066 * math.sin(turbulenceScale * 0.35)))
      // uRotation1
      ..setFloat(22, math.cos(rotation1))
      ..setFloat(23, math.sin(rotation1))
      // uRotation2
      ..setFloat(24, math.cos(rotation2))
      ..setFloat(25, math.sin(rotation2))
      // uRotation3
      ..setFloat(26, math.cos(rotation3))
      ..setFloat(27, math.sin(rotation3));
  }
}