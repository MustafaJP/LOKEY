import 'dart:math' as math;
import 'package:flutter/material.dart';

class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final List<Color> colors = [
      Colors.greenAccent, // Too Little
      Colors.lightBlue, // Bit Low
      Colors.lightGreen, // Perfect
      Colors.orange, // Bit High
      Colors.redAccent // Too High
    ];
    final List<double> stops = [
      0.2,
      0.4,
      0.6,
      0.8,
      1.0
    ]; // Distribution of colors

    final double radius = size.width / 2;
    final double centerX = size.width / 2;
    final double centerY = size.height;
    final double arcThickness = 20; // Change thickness here
    final double startAngle = 0; // Start angle from top
    final double sweepAngle = -math.pi;

    for (int i = 0; i < colors.length; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = arcThickness;

      double segmentAngleStart = sweepAngle * stops[i];
      double segmentAngleEnd = i == 0 ? 0 : sweepAngle * stops[i - 1];

      // Draw the arc for each segment
      canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        startAngle + segmentAngleStart,
        segmentAngleEnd - segmentAngleStart,
        false,
        paint,
      );
    }

    // Text positions
    final List<String> texts = [
      'Too High\n\$26,000',
      'Bit High\n\$19,000',
      'Perfect\n\$16,000',
      'Bit Low\n\$13,000',
      'Too Little\n\$6,000'
    ];
    final double textAngleGap =
        math.pi / (texts.length - 1); // Angle between each text
    final double textPadding = 50; // Padding between text and circle

    for (int i = 0; i < texts.length; i++) {
      final double angle =
          startAngle - (textAngleGap * i); // Use + instead of -
      final double x = centerX + (radius + textPadding) * math.cos(angle);
      final double y = centerY + (radius + textPadding) * math.sin(angle);

      final textStyle = TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

      TextSpan span = TextSpan(
        style: textStyle,
        text: texts[i],
      );

      TextPainter textPainter = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(canvas,
          Offset(x - textPainter.width / 2, y - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
