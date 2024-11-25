import 'dart:convert';

import 'package:fitness_tracker/models/exercise.dart';
import 'package:fitness_tracker/models/workout.dart';
import 'package:fitness_tracker/models/workout_exercise.dart';
import 'package:flutter/services.dart';

Future<List<Exercise>> loadExercisesFromJson() async {
  // Charger le fichier JSON
  final String jsonString = await rootBundle.loadString('assets/exo.json');

  // Décoder le fichier en une liste dynamique
  final List<dynamic> jsonData = jsonDecode(jsonString);

  // Transformer chaque élément en un objet `Exercise`
  return jsonData.map((item) => Exercise.fromJson(item)).toList();
}

List<Exercise> getDefaultExercise() {
  return [
    Exercise(
      category: "strength",
      equipment: "barbell",
      force: "push",
      id: "bench_press",
      images: ["https://example.com/bench_press1.jpg"],
      instructions: [
        "Lie on a flat bench holding a barbell.",
        "Lower the bar to your chest.",
        "Press it back up to the starting position."
      ],
      level: "intermediate",
      name: "Bench Press",
      primaryMuscles: ["chest"],
      secondaryMuscles: ["triceps", "shoulders"],
    ),
    Exercise(
      category: "strength",
      equipment: "barbell",
      force: "push",
      id: "squat",
      images: ["https://example.com/squat1.jpg"],
      instructions: [
        "Stand with your feet shoulder-width apart, holding a barbell on your shoulders.",
        "Lower your body by bending your knees.",
        "Return to the starting position."
      ],
      level: "intermediate",
      name: "Squat",
      primaryMuscles: ["quadriceps"],
      secondaryMuscles: ["glutes", "hamstrings"],
    ),
    Exercise(
      category: "strength",
      equipment: "barbell",
      force: "pull",
      id: "deadlift",
      images: ["https://example.com/deadlift.jpg"],
      instructions: [
        "Stand with your feet shoulder-width apart, gripping the barbell.",
        "Lift the bar by extending your hips and knees.",
        "Lower the bar to the starting position."
      ],
      level: "advanced",
      name: "Deadlift",
      primaryMuscles: ["back"],
      secondaryMuscles: ["glutes", "hamstrings"],
    ),
    Exercise(
      category: "cardio",
      equipment: "body only",
      force: "none",
      id: "running",
      images: ["https://example.com/running.jpg"],
      instructions: ["Run at a moderate pace for 30 minutes."],
      level: "beginner",
      name: "Running",
      primaryMuscles: ["cardiovascular_system"],
      secondaryMuscles: [],
    ),
    Exercise(
      category: "strength",
      equipment: "dumbbell",
      force: "push",
      id: "shoulder_press",
      images: ["https://example.com/shoulder_press.jpg"],
      instructions: [
        "Sit on a bench with back support holding dumbbells at shoulder level.",
        "Press the dumbbells overhead until your arms are fully extended.",
        "Lower the dumbbells back to the starting position."
      ],
      level: "beginner",
      name: "Shoulder Press",
      primaryMuscles: ["shoulders"],
      secondaryMuscles: ["triceps"],
    ),
    Exercise(
      category: "strength",
      equipment: "body only",
      force: "push",
      id: "push_up",
      images: ["https://example.com/push_up.jpg"],
      instructions: [
        "Start in a plank position.",
        "Lower your body until your chest is just above the floor.",
        "Push back up to the starting position."
      ],
      level: "beginner",
      name: "Push Up",
      primaryMuscles: ["chest"],
      secondaryMuscles: ["triceps", "shoulders"],
    ),
  ];
}


Future<Exercise?> findExerciseById(String id) async {
  // Charger les exercices à partir du JSON
  final exercises = await loadExercisesFromJson();
  
  // Trouver l'exercice correspondant à l'ID
  return exercises.firstWhere(
    (exercise) => exercise.id == id,
    orElse: () => Exercise(
      category: "strength",
      equipment: "body only",
      force: "none",
      id: "unknown",
      images: [],
      instructions: [],
      level: "beginner",
      name: "Unknown",
      primaryMuscles: [],
      secondaryMuscles: [],
    ),
  );
}

Future<List<Workout>> getDefaultWorkout() async {
  // Charger les exercices dynamiquement
  final benchPress = await findExerciseById("Barbell_Bench_Press_-_Medium_Grip");
  final shoulderPress = await findExerciseById("Barbell_Shoulder_Press");
  final deadlift = await findExerciseById("Barbell_Deadlift");
  final squat = await findExerciseById("Barbell_Full_Squat");
  final abs = await findExerciseById("Ab_Crunch_Machine");

  return [
    Workout(
      name: "Push Day",
      date: DateTime.now().subtract(const Duration(days: 10)),
      workoutImage: 'assets/Strength.jpg',
      exercises: [
        WorkoutExercise(
          exercise: benchPress!,
          sets: 4,
          reps: 10,
          weight: 80,
        ),
        WorkoutExercise(
          exercise: shoulderPress!,
          sets: 3,
          reps: 12,
          weight: 20,
        ),
      ],
    ),
    Workout(
      name: "Pull Day",
      date: DateTime.now().subtract(const Duration(days: 9)),
      workoutImage: 'assets/Pull-Up.jpg',
      exercises: [
        WorkoutExercise(
          exercise: deadlift!,
          sets: 4,
          reps: 8,
          weight: 120,
        ),
      ],
    ),
    Workout(
      name: "Leg Day",
      date: DateTime.now().subtract(const Duration(days: 7)),
      workoutImage: 'assets/Strength.jpg',
      exercises: [
        WorkoutExercise(
          exercise: squat!,
          sets: 4,
          reps: 10,
          weight: 100,
        ),
        WorkoutExercise(
          exercise: benchPress,
          sets: 4,
          reps: 15,
          weight: 135,
        ),
        WorkoutExercise(
          exercise: deadlift,
          sets: 4,
          reps: 8,
          weight: 150,
        ),
        WorkoutExercise(
          exercise: benchPress,
          sets: 5,
          reps: 4,
          weight: 220,
        ),
        WorkoutExercise(
          exercise: abs!,
          sets: 5,
          reps: 5,
          weight: 60,
        ),
      ],
    ),
    Workout(
      name: "Abs",
      date: DateTime.now().subtract(const Duration(days: 4)),
      workoutImage: 'assets/Cardio.jpg',
      exercises: [
        WorkoutExercise(
          exercise: abs,
          sets: 1,
          reps: 1,
          weight: 0,
        ),
      ],
    ),
  ];
}
