import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/helpers/helpers.dart';
import 'package:flutter/material.dart';

class Comparing extends StatelessWidget {
  Comparing({super.key});
  final String level = getLevel();

  static const Map<String, Color> levelColors = {
    'Beginner': Colors.green,
    'Intermediate': Colors.yellow,
    'Advanced': Colors.orange,
    'Pro': Colors.red,
  };

  String getBackLevel() => 'Beginner';
  String getChestLevel() => 'Intermediate';
  String getLegsLevel() => 'Advanced';

  Color? getColorForLevel(String level) => levelColors[level];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(22),
      elevation: 5,
      color: ColorsHelper.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Strength Progress',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.bar_chart_outlined,
                  size: 24,
                ),
              ],
            ),
            Text(
              level,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                for (var layer in _getProgressLayers())
                  Image.asset(
                    layer['asset'],
                    height: 300,
                    width: 300,
                    color: layer['color'],
                  ),
              ],
            ),
            const SizedBox(height: 20),
            const LevelLegend(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getProgressLayers() {
    return [
      {'asset': 'assets/progress/Canard-muscles.png', 'color': ColorsHelper.backgroundColor},
      {'asset': 'assets/progress/canard-muscles-contour.png', 'color': null},
      {'asset': 'assets/progress/canard-back.png', 'color': getColorForLevel(getBackLevel())},
      {'asset': 'assets/progress/canard-chest.png', 'color': getColorForLevel(getChestLevel())},
      {'asset': 'assets/progress/canard-quads.png', 'color': getColorForLevel(getLegsLevel())},
      {'asset': 'assets/progress/canard-harmstring.png', 'color': getColorForLevel(getLegsLevel())},
      {'asset': 'assets/progress/canard-calves.png', 'color': getColorForLevel(getLegsLevel())},
      {'asset': 'assets/progress/canard-abs.png', 'color': getColorForLevel(getBackLevel())},
    ];
  }
}

class LevelLegend extends StatelessWidget {
  const LevelLegend({super.key});

  @override
  Widget build(BuildContext context) {
    const levels = [
      {'label': 'Beginner', 'color': Colors.green},
      {'label': 'Intermediate', 'color': Colors.yellow},
      {'label': 'Advanced', 'color': Colors.orange},
      {'label': 'Pro', 'color': Colors.red},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Level Legend',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 20,
          runSpacing: 10,
          children: levels.map((level) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    color: level['color'] as Color,
                    shape: BoxShape.rectangle,
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: Text(
                    level['label'] as String,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
