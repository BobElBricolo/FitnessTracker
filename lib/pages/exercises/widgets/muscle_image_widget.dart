import 'package:fitness_tracker/helpers/helpers.dart';
import 'package:flutter/material.dart';

class MuscleImageWidget extends StatelessWidget {
  final String muscle;

  const MuscleImageWidget({super.key, required this.muscle});

  @override
  Widget build(BuildContext context) {
    final imagePath = getMuscleImage(muscle);

    return ClipOval(
      child: Image.asset(
        imagePath,
        width: 100, 
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
