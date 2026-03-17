import 'package:flutter/material.dart';
import '../theme/combine_colors.dart';

class ScanLinesPainter extends CustomPainter {
  final Animation<double> animation;

  ScanLinesPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.02)
      ..strokeWidth = 0.5;

    for (double y = 0; y < size.height; y += 2.5) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    final sweepY = animation.value * (size.height + 100) - 50;
    final sweepPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          CombineColors.cyan.withOpacity(0.04),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, sweepY - 40, size.width, 80));

    canvas.drawRect(
      Rect.fromLTWH(0, sweepY - 40, size.width, 80),
      sweepPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ScanLinesPainter old) => false;
}
