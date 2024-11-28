import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:flutter/material.dart';

class Duck extends StatelessWidget {
  final Color duckColor;
  final Color? backColor;
  final Color? chestColor;
  final Color? quadsColor;
  final Color? harmstringColor;
  final Color? calvesColor;
  final Color? absColor;
  final Color? forearmsColor;
  final Color? shouldersColor;
  final Color? tricepsColor;
  final Color? bicepsColor;
  final Color? glutesColor;

  const Duck({
    super.key,
    required this.duckColor, 
    this.backColor,
    this.chestColor,
    this.quadsColor,
    this.harmstringColor,
    this.calvesColor,
    this.absColor,
    this.forearmsColor,
    this.shouldersColor,
    this.tricepsColor,
    this.bicepsColor,
    this.glutesColor,
  });

  List<Map<String, dynamic>> _getProgressLayers() {
    return [
      {'asset': 'assets/progress/Canard-muscles.png', 'color': ColorsHelper.backgroundColor},
      {'asset': 'assets/progress/canard-muscles-contour.png', 'color': null},
      {'asset': 'assets/progress/canard-back.png', 'color': backColor ?? duckColor},
      {'asset': 'assets/progress/canard-chest.png', 'color': chestColor ?? duckColor},
      {'asset': 'assets/progress/canard-quads.png', 'color': quadsColor ?? duckColor},
      {'asset': 'assets/progress/canard-harmstring.png', 'color': harmstringColor ?? duckColor},
      {'asset': 'assets/progress/canard-calves.png', 'color': calvesColor ?? duckColor},
      {'asset': 'assets/progress/canard-abs.png', 'color': absColor ?? duckColor},
      {'asset': 'assets/progress/canard-forearms.png', 'color': forearmsColor ?? duckColor},
      {'asset': 'assets/progress/canard-shoulders.png', 'color': shouldersColor ?? duckColor},
      {'asset': 'assets/progress/canard-triceps.png', 'color': tricepsColor ?? duckColor},
      {'asset': 'assets/progress/canard-biceps.png', 'color': bicepsColor ?? duckColor},
      {'asset': 'assets/progress/canard-glutes.png', 'color': glutesColor ?? duckColor},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (var layer in _getProgressLayers())
          Image.asset(
            layer['asset'],
            height: 300,
            width: 300,
            color: layer['color'],
          ),
      ],
    );
  }
}
