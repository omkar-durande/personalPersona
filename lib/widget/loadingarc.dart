import 'package:flutter/material.dart';
import 'dart:math';

class RotatingArcRing extends StatefulWidget {
  const RotatingArcRing({super.key});

  @override
  State<RotatingArcRing> createState() => _RotatingArcRingState();
}

class _RotatingArcRingState extends State<RotatingArcRing> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 3), vsync: this)
      ..repeat(); // Loop forever
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi, // full circle
          child: child,
        );
      },
      child: CustomPaint(size: const Size(10, 10), painter: ArcRingPainter()),
    );
  }
}

class ArcRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = 10.0;

    final backgroundPaint = Paint()
      ..color =
          const Color(0xFF1C1C1C) // light gray
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final arcPaint = Paint()
      ..color =
          const Color(0xFF94938D) // green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // Draw background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Arc setup
    const arcCount = 3;
    const arcLength = pi / 3; // 60 degrees
    const spaceBetween = 2 * pi / arcCount; // 120 degrees

    for (int i = 0; i < arcCount; i++) {
      final startAngle = i * spaceBetween;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        arcLength,
        false,
        arcPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
