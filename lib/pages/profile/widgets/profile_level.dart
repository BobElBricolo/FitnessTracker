
import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/helpers/helpers.dart';
import 'package:flutter/material.dart';

// Enum of gym levels
enum GymLevel {
  beginner,
  intermediate,
  advanced,
  expert,
}

class ProfileLevelCard extends StatelessWidget {
  ProfileLevelCard({super.key});


  final level = getLevel();

  final gymLevels = {
    'beginner': {
      'phrase': 'Quack-tastic start! Every duck waddles before it soars!',
      'image': 'assets/gym_level/beginner.png',
    },
    'intermediate': {
      'phrase': 'You’re making waves, keep paddling like a pro duck!',
      'image': 'assets/gym_level/intermediate.png',
    },
    'advanced': {
      'phrase': 'Feather your fitness! You’re flying high now!',
      'image': 'assets/gym_level/advenced.png',
    },
    'expert': {
      'phrase': 'You’ve reached peak duck power! Time to soar like a legend!',
      'image': 'assets/gym_level/pro.png',
    },
    'default': {
      'phrase': 'Stay duck-termined! Every step gets you closer!',
      'image': 'assets/gym_level/default.png',
    },
  };

  String get imageUrl {
    try {
      return gymLevels[level]!['image'].toString();
    } catch (e) {
      return gymLevels['default']!['image'].toString();
    }
  }

  String get phrase {
    try {
      return gymLevels[level]!['phrase'].toString();
    } catch (e) {
      return gymLevels['default']!['phrase'].toString();
    }
  }

  //format the level string
  String get levelStr {
    return level[0].toUpperCase() + level.substring(1);
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16, left: 22, right: 22),
      elevation: 4,
      color: ColorsHelper.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    levelStr,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    phrase,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
