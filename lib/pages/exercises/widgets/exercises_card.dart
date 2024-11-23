import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/helpers/helpers.dart';
import 'package:fitness_tracker/pages/exercise_details/exercise_details.dart';
import 'package:flutter/material.dart';
import 'package:fitness_tracker/models/exercise.dart';

class ExerciseCardWithDetails extends StatelessWidget {
  final Exercise exercise;

  const ExerciseCardWithDetails({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: ColorsHelper.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExerciseDetailPage(exercise: exercise),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: ClipOval(
                child: Image.asset(
                  getMuscleImage(exercise.primaryMuscles.first),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                exercise.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                "Primary: ${exercise.primaryMuscles.join(', ')}",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 24,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
