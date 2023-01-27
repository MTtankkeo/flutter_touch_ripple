import 'dart:math';

import 'package:flutter/material.dart';



class RipplePainter extends CustomPainter {
  const RipplePainter({
    required this.centerToRatio,
    required this.radius,
    required this.color,
    required this.percent,
  });

  final Offset centerToRatio;
  final BorderRadius radius;
  final Color color;
  final double percent;


  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color
      ..isAntiAlias = true;



    // double(0 ~ 1)의 절대 값으로 정의됩니다.
    Offset centerToRadiusRatio = Offset(centerToRatio.dx.abs() * 2, centerToRatio.dy.abs() * 2);



    // 중심으로 부터 떨어진 거리를 퍼센트로 정의합니다.
    //
    // 만약 사용자가 맨 아래를 클릭한다면 dx: 0, dy: 1이 될 것입니다.
    // 오른쪽 끝 맨 오른쪽을 클릭한다면 dx: 1, dy: 1이 됩니다.
    double centerToRatioDx = size.width * centerToRadiusRatio.dx;
    double x = (size.width + centerToRatioDx) / 2;

    double centerToRatioDy = size.height * centerToRadiusRatio.dy;
    double y = (size.height + centerToRatioDy) / 2;



    // x와 y의 거리를 구합니다. (원의 반지름을 기준으로 정의합니다)
    // (x1 * x2) + (y1 * y2)
    double distance = sqrt((x * x) + (y * y));
    
    // 리플 효과의 크기 (원의 지름)
    double drawSize = distance;



    canvas.drawCircle(
      Offset(
        size.width * (centerToRatio.dx + 0.5),
        size.height * (centerToRatio.dy + 0.5),
      ),
      drawSize * percent,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}