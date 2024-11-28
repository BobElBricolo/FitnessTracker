import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:fitness_tracker/models/workout.dart';
import 'package:fitness_tracker/models/workout_exercise.dart';

class WorkoutDetailPage extends StatelessWidget {
  final Workout workout;

  const WorkoutDetailPage({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsHelper.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsHelper.backgroundColor,
        title: Text(
          workout.name,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: ColorsHelper.textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image du workout
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    workout.image,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Nom du workout
              Text(
                workout.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Durée et date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        '${workout.time} min',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        '${workout.date.day}/${workout.date.month}/${workout.date.year}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Liste des exercices
              const Text(
                'Exercises:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: workout.exercises.length,
                itemBuilder: (context, index) {
                  final workoutExercise = workout.exercises[index];
                  return WorkoutExerciseCard(
                    workoutExercise: workoutExercise,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkoutExerciseCard extends StatelessWidget {
  final WorkoutExercise workoutExercise;

  const WorkoutExerciseCard({super.key, required this.workoutExercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsHelper.cardColor,
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nom de l'exercice
            Text(
              workoutExercise.exercise.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Catégorie et niveau
            Row(
              children: [
                Text(
                  'Category: ${workoutExercise.exercise.category}',
                  style: const TextStyle(fontSize: 14),
                ),
                const Spacer(),
                Text(
                  'Level: ${workoutExercise.exercise.level}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Liste des séries et poids
            const Text(
              'Sets & Weights:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: workoutExercise.repWeightList.length,
              itemBuilder: (context, index) {
                final set = workoutExercise.repWeightList[index];
                return Text(
                  'Set ${index + 1}: ${set.item1} reps @ ${set.item2} lbs',
                  style: const TextStyle(fontSize: 14),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
