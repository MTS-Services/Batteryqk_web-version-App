import 'package:flutter/material.dart';

class GradientBorderPainter extends CustomPainter {
  final double animationValue;

  GradientBorderPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final radius = 25.0;

    final Paint paint =
    Paint()
      ..shader = LinearGradient(
        colors: [Colors.blueAccent, Colors.purpleAccent, Colors.cyanAccent],
        stops: [
          animationValue,
          (animationValue + 0.3) % 1.0,
          (animationValue + 0.6) % 1.0,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        tileMode: TileMode.mirror,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10; // Bold border

    final rRect = RRect.fromRectAndRadius(
      rect.deflate(3),
      Radius.circular(radius),
    );
    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant GradientBorderPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
