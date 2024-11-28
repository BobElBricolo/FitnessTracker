import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/helpers/level_helper.dart';
import 'package:fitness_tracker/pages/progress/duck.dart';
import 'package:flutter/material.dart';

/// Widget principal
class Comparing extends StatelessWidget {
  const Comparing({super.key});

  static const Map<String, Color> levelColors = {
    'Beginner': Colors.green,
    'Intermediate': Colors.yellow,
    'Advanced': Colors.orange,
    'Pro': Colors.red,
  };

  Color? getColorForLevel(String? level) => levelColors[level];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String?>>(
      future: _fetchLevels(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading levels'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No levels found'));
        }

        final levels = snapshot.data!;
        final chestColor = getColorForLevel(levels['chestLevel']);
        final backColor = getColorForLevel(levels['backLevel']);
        final legColor = getColorForLevel(levels['legsLevel']);

        return Card(
          margin: const EdgeInsets.only(bottom: 22, left: 16, right: 16),
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
                const SizedBox(height: 10),
                Text(
                  levels['mainLevel'] ?? 'Unknown',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 15),
                Duck(
                  duckColor: ColorsHelper.backgroundColor,
                  backColor: backColor,
                  bicepsColor: backColor,
                  forearmsColor: backColor,
                  chestColor: chestColor,
                  shouldersColor: chestColor,
                  tricepsColor: chestColor,
                  glutesColor: legColor,
                  quadsColor: legColor,
                  harmstringColor: legColor,
                  calvesColor: legColor,
                ),
                const SizedBox(height: 20),
                const LevelLegend(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<Map<String, String?>> _fetchLevels() async {
    final fitnessCalculator = FitnessLevelCalculator();
    final mainLevel = await fitnessCalculator.getUserMainLevel();
    final backLevel = await fitnessCalculator.getBackLevel();
    final chestLevel = await fitnessCalculator.getChestLevel();
    final legsLevel = await fitnessCalculator.getLegsLevel();

    return {
      'mainLevel': mainLevel?.name,
      'backLevel': backLevel?.name,
      'chestLevel': chestLevel?.name,
      'legsLevel': legsLevel?.name,
    };
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
