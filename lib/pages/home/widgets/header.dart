import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 100,
        child: Stack(children: [
          CustomPaint(
            size: const Size(double.infinity, 100),
            painter: _HeaderPainter(),
          ),
          
      const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bob ElBricolo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
        ]));
  }
}

class _HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint backColor = Paint()..color = ColorsHelper.primaryColor;
    Paint circleColor = Paint()..color = Colors.white.withOpacity(0.2);

    canvas.drawRect(
        Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)),
        backColor);

    canvas.drawCircle(Offset(size.width * .67, 10), 45, circleColor);
    canvas.drawCircle(Offset(size.width * .60, 130), 10, circleColor);
    canvas.drawCircle(Offset(size.width * .70, 160), 10, circleColor);
    canvas.drawCircle(
        Offset(size.width - 10, size.height - 10), 55, circleColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
