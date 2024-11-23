import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/helpers/helpers.dart';
import 'package:fitness_tracker/models/exercise.dart';
import 'package:fitness_tracker/pages/exercise_details/widgets/exercise_description.dart';
import 'package:fitness_tracker/pages/exercise_details/widgets/exercise_stats.dart';
import 'package:fitness_tracker/pages/exercise_details/widgets/graph/exercise_data_point.dart';
import 'package:fitness_tracker/pages/exercise_details/widgets/graph/exercise_graph.dart';
import 'package:flutter/material.dart';

class ExerciseDetailPage extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetailPage({super.key, required this.exercise});

  List<ExerciseDataPoint> getExerciseHistoryAsPoint(String exerciseId) {
    final history = getExerciseHistory(exerciseId);

    return history.map((entry) {
      return ExerciseDataPoint(
        date: entry['date'] as DateTime,
        weight: (entry['weight'] as int).toDouble(),
        reps: (entry['reps'] as int).toDouble(),
        sets: (entry['sets'] as int).toDouble(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<ExerciseDataPoint> exerciseHistory =
        getExerciseHistoryAsPoint(exercise.id);

    return Scaffold(
      backgroundColor: ColorsHelper.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsHelper.backgroundColor,
        title: Text(exercise.name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: ColorsHelper.textColor),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExerciseStats(
              equipment: exercise.equipment,
              level: exercise.level,
              category: exercise.category,
              oneRepMax:
                  formatOneRepMax(calculateOneRepMaxForExercise(exercise.id)),
            ),
            const SizedBox(height: 32),

            GraphWidget(data: exerciseHistory),
            const SizedBox(height: 37),
            DescriptionCard(
              title: 'Description',
              instructions: exercise.instructions,
            )
          ],
        ),
      ),
    );
  }
}
