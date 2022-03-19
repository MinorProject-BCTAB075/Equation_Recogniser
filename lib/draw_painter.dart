import 'package:flutter/material.dart';
import 'package:equation_recognizer/constant.dart';


class drawingPainter extends CustomPainter {
  drawingPainter({required this.offsetPoints});
  List<Offset> offsetPoints;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < offsetPoints.length - 1; i++) {
      if (offsetPoints[i] != Offset.zero &&
          offsetPoints[i + 1] != Offset.zero) {
        canvas.drawLine(offsetPoints[i], offsetPoints[i + 1], drawingPaint);
      }
    }
  }

  @override
  bool shouldRepaint(drawingPainter oldDelegate) => true;
}
