import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/pages/home/widgets/activity.dart';
import 'package:fitness_tracker/pages/home/widgets/preset_workouts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsHelper.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Stack(
            children: [
              CustomPaint(
                size: const Size(double.infinity, 100),
                painter: _AppBarPainter(),
              ),
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const PresetWorkouts(),
            const SizedBox(
              height: 5,
            ),
            RecentActivities(),
          ],
        ));
  }
}

class _AppBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint backColor = Paint()..color = ColorsHelper.primaryColor;
    Paint circleColor = Paint()..color = Colors.white.withOpacity(0.2);

    canvas.drawRect(
        Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)),
        backColor);

    canvas.drawCircle(Offset(size.width * .67, 10), 45, circleColor);
    canvas.drawCircle(
        Offset(size.width - 10, size.height - 10), 55, circleColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
