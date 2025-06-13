import 'package:flutter/material.dart';

class AnimatedButtonBorderPainter extends CustomPainter {
  final double animationValue;

  AnimatedButtonBorderPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final borderRadius = 12.0;

    final gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: 6.28,
      transform: GradientRotation(6.28 * animationValue),
      colors: const [
        Colors.blueAccent, Colors.purpleAccent, Colors.cyanAccent
      ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final rRect = RRect.fromRectAndRadius(
      rect.deflate(1.5),
      Radius.circular(borderRadius),
    );

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant AnimatedButtonBorderPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
