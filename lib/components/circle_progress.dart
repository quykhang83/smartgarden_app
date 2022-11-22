import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smartgarden_app/models/sensor.dart';

class CircleProgress extends CustomPainter {
  double value;
  Sensor sensor;

  CircleProgress({
    required this.value,
    required this.sensor
  });

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double maximumValue = sensor.maximumValue;

    Paint outerCircle = Paint()
      ..strokeWidth = 14
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    Paint drawArc = Paint()
      ..strokeWidth = 14
      ..color = sensor.color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;


    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 14;
    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * pi * (value / maximumValue);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, drawArc);
  }
}
