import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 160, 111, 72)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0016944, size.height * -0.0014500);
    path_0.lineTo(size.width * -0.0027778, size.height * 0.7462500);
    path_0.quadraticBezierTo(size.width * 0.0845833, size.height * 0.4589375,
        size.width * 0.2757130, size.height * 0.4602750);
    path_0.cubicTo(
        size.width * 0.4766389,
        size.height * 0.4883125,
        size.width * 0.5276111,
        size.height * 0.9234875,
        size.width * 0.7476944,
        size.height * 0.9349000);
    path_0.quadraticBezierTo(size.width * 0.8909537, size.height * 0.9400500,
        size.width * 1.0012315, size.height * 0.7463625);
    path_0.lineTo(size.width * 1.0039444, size.height * -0.0057500);
    path_0.lineTo(size.width * -0.0009259, size.height * -0.0023875);

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
