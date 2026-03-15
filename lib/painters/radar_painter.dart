import 'dart:math';
import 'package:flutter/material.dart';

class RadarPainter extends CustomPainter {
  final double sweep;
  final Color color;

  RadarPainter({required this.sweep, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 4;

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = color.withOpacity(0.4)
        ..strokeWidth = 1.5,
    );

    canvas.drawCircle(
      center,
      radius * 0.66,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = color.withOpacity(0.15)
        ..strokeWidth = 0.8,
    );

    canvas.drawCircle(
      center,
      radius * 0.33,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = color.withOpacity(0.1)
        ..strokeWidth = 0.8,
    );

    final crossPaint = Paint()
      ..color = color.withOpacity(0.12)
      ..strokeWidth = 0.5;

    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      crossPaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      crossPaint,
    );

    if (sweep >= 0) {
      final angle = sweep * 2 * pi;
      final lineEnd = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      canvas.drawLine(
        center,
        lineEnd,
        Paint()
          ..color = color.withOpacity(0.7)
          ..strokeWidth = 1.5,
      );

      final trailPath = Path()..moveTo(center.dx, center.dy);
      for (double a = angle - 0.6; a <= angle; a += 0.05) {
        trailPath.lineTo(
          center.dx + radius * cos(a),
          center.dy + radius * sin(a),
        );
      }
      trailPath.close();

      canvas.drawPath(
        trailPath,
        Paint()
          ..color = color.withOpacity(0.08)
          ..style = PaintingStyle.fill,
      );
    }

    canvas.drawCircle(center, 3, Paint()..color = color);
    canvas.drawCircle(
      center,
      6,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = color.withOpacity(0.3)
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(covariant RadarPainter old) =>
      sweep != old.sweep || color != old.color;
}
