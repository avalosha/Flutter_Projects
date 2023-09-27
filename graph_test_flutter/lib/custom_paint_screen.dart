import 'package:flutter/material.dart';
import 'dart:math';

class SinCanvas extends StatelessWidget {
  const SinCanvas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        size: Size(600, 400),
        painter: SinPainter(),
      ),
    );
  }
}

class SinPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final midY = size.height / 2;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawLine(Offset(0, midY), Offset(size.width, midY), paint);
    var pt = Offset(0, midY);
    for (double i = 0; i < 600; i += 0.1) {
      final npt = Offset(i, midY - sin(i / 50) * 100);
      canvas.drawLine(pt, npt, paint);
      pt = npt;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
