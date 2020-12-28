import 'package:flutter/material.dart';
import 'dart:math';
import 'package:ontrack_time_tracker/theme/colors.dart';

// Represents the circular progress bar on the home screen
class CircularProgressBar extends CustomPainter {
  double currentProgress;
  CircularProgressBar(this.currentProgress);

  @override
  void paint(Canvas canvas, Size size) {
    double outlineWidth = 25;

    Paint outerCircle = Paint()
      ..strokeWidth = outlineWidth
      ..color = ThemeColors.White
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = outlineWidth
      ..style = PaintingStyle.stroke
      ..color = ThemeColors.Blue
      ..strokeCap = StrokeCap.butt;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2 * 1.2, size.height / 2 * 1.2) - outlineWidth;
    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * pi * (currentProgress / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, completeArc);

  }

  @override
  bool shouldRepaint (CustomPainter old) {
    return true;
  }
}