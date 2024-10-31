import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 200,
        child: Stack(children: [
          CustomPaint(
            size: const Size(double.infinity, 200),
            painter: _HeaderPainter(),
          ),
          Positioned(
              top: 35,
              left: 17,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              )),
          const Positioned(
              top: 30,
              right: 33,
              child: CircleAvatar(
                minRadius: 30,
                maxRadius: 30,
                foregroundImage: AssetImage('assets/Profile-Picture.jpeg'),
              )),
          const Positioned(
              left: 33,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Bob ElBricolo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ))
        ]));
  }
}

class _HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint backColor = Paint()..color = const Color(0xff18b0e8);
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
