import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Graph extends StatelessWidget {
  const Graph({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: SizedBox(
      width: double.infinity,
      child: GraphArea(),
    ));
  }
}

class GraphArea extends StatefulWidget {
  const GraphArea({super.key});

  @override
  State<GraphArea> createState() => _GraphAreaState();
}

class _GraphAreaState extends State<GraphArea>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  List<DataPoint> data = [
    DataPoint(day: 1, steps: 2000),
    DataPoint(day: 2, steps: 5500),
    DataPoint(day: 3, steps: 3000),
    DataPoint(day: 4, steps: 3500),
    DataPoint(day: 5, steps: 4000),
    DataPoint(day: 6, steps: 4500),
    DataPoint(day: 7, steps: 3000),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_animationController.status == AnimationStatus.completed) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      },
      child: CustomPaint(
        painter: GraphPainter(_animationController.view, data: data),
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  final List<DataPoint> data;
  final Animation<double> _sizeAnimation;
  final Animation<double> _dotSizeAnimation;

  GraphPainter(Animation<double> animation, {required this.data})
      : _sizeAnimation = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
                parent: animation, curve: const Interval(0.0, 0.75, curve: Curves.easeInOutCubicEmphasized))),
        
        _dotSizeAnimation = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
                parent: animation, curve: const Interval(0.5, 1, curve: Curves.easeInCirc))),
        super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    var xSpacing = size.width / (data.length - 1);
    var maxStep = data.fold(data[0], (p, c) => p.steps > c.steps ? p : c).steps;

    var yRatio = size.height / maxStep;
    var curveOffset = xSpacing * 0.3;

    List<Offset> offsets = [];

    for (int i = 0; i < data.length; i++) {
      offsets.add(Offset(i * xSpacing,
          size.height - data[i].steps * yRatio * _sizeAnimation.value));
    }

    Paint linePaint = Paint()
      ..color = const Color(0xff30c3f9)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    Paint shadowPaint = Paint()
      ..color = const Color.fromARGB(255, 131, 220, 252)
      ..strokeWidth = 3
      ..maskFilter = const ui.MaskFilter.blur(BlurStyle.normal, 3)
      ..style = PaintingStyle.stroke;

    Paint fillPaint = Paint()
      ..shader = ui.Gradient.linear(
          Offset(size.width / 2, 0),
          Offset(size.width / 2, size.height),
          [const Color(0xff30c3f9), Colors.white])
      ..style = PaintingStyle.fill;

    Paint dotOutlinePaint = Paint()
      ..color = Colors.white.withAlpha(200)
      ..strokeWidth = 8;

    Paint dotPaint = Paint()
      ..color = const Color(0xff30c3f9)
      ..strokeWidth = 8;

    Path linePath = Path();

    Offset start = offsets[0];

    linePath.moveTo(start.dx, start.dy);

    for (int i = 1; i < offsets.length; i++) {
      var x = offsets[i].dx;
      var y = offsets[i].dy;
      var c1x = start.dx + curveOffset;
      var c1y = start.dy;
      var c2x = x - curveOffset;
      var c2y = y;

      linePath.cubicTo(c1x, c1y, c2x, c2y, x, y);
      start = offsets[i];
    }

    Path fillPath = Path.from(linePath);

    fillPath.lineTo(offsets.last.dx, size.height);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, shadowPaint);
    canvas.drawPath(linePath, linePaint);

    canvas.drawCircle(offsets[3], 15 * _dotSizeAnimation.value, dotOutlinePaint);
    canvas.drawCircle(offsets[3], 6*_dotSizeAnimation.value, dotPaint);
  }

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    // If the data changes, we should repaint
    return data != oldDelegate.data;
  }
}

class DataPoint {
  final int day;
  final int steps;

  DataPoint({required this.day, required this.steps});
}
