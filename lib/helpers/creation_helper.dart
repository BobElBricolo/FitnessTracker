import 'dart:convert';

import 'package:fitness_tracker/models/exercise.dart';
import 'package:fitness_tracker/models/workout.dart';
import 'package:fitness_tracker/models/workout_exercise.dart';
import 'package:flutter/services.dart';

class CreationHelper {
  // Liste statique pour stocker les workouts
  static List<Workout>? _workouts;

  // Fonction pour initialiser et récupérer les workouts
  static Future<List<Workout>> getWorkouts() async {
    // Si les workouts sont déjà chargés, les retourner
    _workouts ??= await getDefaultWorkout();

        print("Length of the list of workouts Exercices: ${_workouts!.length}");


    // New list without the preset workouts
    List<Workout> workouts = _workouts!.where((workout) => !workout.isPreset).toList();

        print("Length of the list of workouts real Exercices: ${workouts.length}");


    return workouts;
  }

  // Fonction pour initialiser et récupérer les workouts
  static Future<List<Workout>> getPresetWorkouts() async {
    // Si les workouts sont déjà chargés, les retourner
    _workouts ??= await getDefaultWorkout();

    //Print la length de la liste des workouts Exercices: 7
    print("Length of the list of workouts p Exercices: ${_workouts!.length}");

    // Only return preset workouts
    List<Workout> workouts = _workouts!.where((workout) => workout.isPreset).toList();
        print("Length of the list of workouts preset Exercices: ${workouts.length}");

    return workouts;
  }

  // Fonction pour ajouter un workout à la liste
  static Future<void> addWorkout(Workout newWorkout) async {
    // Assurez-vous que la liste est initialisée
    await getWorkouts();


    // Ajouter le nouveau workout au dessus de la liste
    _workouts!.insert(0, newWorkout);

    // Print la length de la liste des workouts Exercices: 8
    print("Length of the list of add: ${_workouts!.length}");
  }
}

Future<List<Exercise>> loadExercisesFromJson() async {
  // Charger le fichier JSON
  final String jsonString = await rootBundle.loadString('assets/exo.json');

  // Décoder le fichier en une liste dynamique
  final List<dynamic> jsonData = jsonDecode(jsonString);

  // Transformer chaque élément en un objet `Exercise`
  return jsonData.map((item) => Exercise.fromJson(item)).toList();
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

Future<List<Workout>> getDefaultWorkout({isNew = false}) async {
  // Charger les exercices dynamiquement
  final benchPress =
      await findExerciseById("Barbell_Bench_Press_-_Medium_Grip");
  final shoulderPress = await findExerciseById("Barbell_Shoulder_Press");
  final deadlift = await findExerciseById("Barbell_Deadlift");
  final squat = await findExerciseById("Barbell_Full_Squat");
  final abs = await findExerciseById("Ab_Crunch_Machine");

  final workouts = [
    Workout(
      name: "Preset Push Day",
      date: DateTime.now().subtract(const Duration(days: 10)),
      workoutImage: 'assets/Strength.jpg',
      time: 60,
      isPreset: true,
      exercises: [
        WorkoutExercise(
          exercise: benchPress!,
          repWeightList: [Tuple(4, 80)], // 4 sets de 80 kg
        ),
        WorkoutExercise(
          exercise: shoulderPress!,
          repWeightList: [Tuple(3, 20)], // 3 sets de 20 kg
        ),
      ],
    ),
    Workout(
      name: "Preset Pull Day",
      date: DateTime.now().subtract(const Duration(days: 9)),
      workoutImage: 'assets/Pull-Up.jpg',
      time: 50,
      isPreset: true,
      exercises: [
        WorkoutExercise(
          exercise: deadlift!,
          repWeightList: [Tuple(4, 120)], // 4 sets de 120 kg
        ),
      ],
    ),
    Workout(
      name: "Push Day",
      date: DateTime.now().subtract(const Duration(days: 10)),
      workoutImage: 'assets/Strength.jpg',
      time: 60,
      exercises: [
        WorkoutExercise(
          exercise: benchPress,
          repWeightList: [Tuple(4, 80)], // 4 sets de 80 kg
        ),
        WorkoutExercise(
          exercise: shoulderPress,
          repWeightList: [Tuple(3, 20)], // 3 sets de 20 kg
        ),
      ],
    ),
    Workout(
      name: "Pull Day",
      date: DateTime.now().subtract(const Duration(days: 9)),
      workoutImage: 'assets/Pull-Up.jpg',
      time: 50,
      exercises: [
        WorkoutExercise(
          exercise: deadlift,
          repWeightList: [Tuple(4, 120)], // 4 sets de 120 kg
        ),
      ],
    ),
    Workout(
      name: "Leg Day",
      date: DateTime.now().subtract(const Duration(days: 1)),
      workoutImage: 'assets/Strength.jpg',
      time: 90,
      exercises: [
        WorkoutExercise(
          exercise: squat!,
          repWeightList: [Tuple(1, 10)], // 4 sets de 100 kg
        ),
        WorkoutExercise(
          exercise: benchPress,
          repWeightList: [Tuple(1, 215)], // 4 sets de 135 kg
        ),
        WorkoutExercise(
          exercise: deadlift,
          repWeightList: [Tuple(4, 225)], // 4 sets de 150 kg
        ),
        WorkoutExercise(
          exercise: benchPress,
          repWeightList: [Tuple(5, 220)], // 5 sets de 220 kg
        ),
        WorkoutExercise(
          exercise: abs!,
          repWeightList: [Tuple(5, 60)], // 5 sets de 60 kg
        ),
      ],
    ),
    Workout(
      name: "Abs",
      date: DateTime.now().subtract(const Duration(days: 2)),
      workoutImage: 'assets/Cardio.jpg',
      time: 20,
      exercises: [
        WorkoutExercise(
          exercise: abs,
          repWeightList: [Tuple(1, 20)], // 1 set sans poids
        ),
      ],
    ),
    Workout(
      name: "Test Day",
      date: DateTime.now().subtract(const Duration(days: 0)),
      workoutImage: 'assets/Strength.jpg',
      time: 90,
      exercises: [
        WorkoutExercise(
          exercise: squat,
          repWeightList: [Tuple(1, 10)], // 4 sets de 100 kg
        ),
        WorkoutExercise(
          exercise: benchPress,
          repWeightList: [Tuple(1, 215)], // 4 sets de 135 kg
        ),
        WorkoutExercise(
          exercise: deadlift,
          repWeightList: [Tuple(4, 225)], // 4 sets de 150 kg
        ),
        WorkoutExercise(
          exercise: benchPress,
          repWeightList: [Tuple(5, 220)], // 5 sets de 220 kg
        ),
        WorkoutExercise(
          exercise: abs,
          repWeightList: [Tuple(5, 60)], // 5 sets de 60 kg
        ),
      ],
    ),
  ];

  if (isNew) {
    workouts.insert(0, await addWorkoutDb());
  }

  return workouts;
}

Future<Workout> addWorkoutDb() async {
  final benchPress =
      await findExerciseById("Barbell_Bench_Press_-_Medium_Grip");
  final shoulderPress = await findExerciseById("Barbell_Shoulder_Press");

  return Workout(
    name: "New workout",
    date: DateTime.now().subtract(const Duration(days: 10)),
    workoutImage: 'assets/Strength.jpg',
    time: 60,
    exercises: [
      WorkoutExercise(
        exercise: benchPress!,
        repWeightList: [Tuple(4, 10)],
      ),
      WorkoutExercise(
        exercise: shoulderPress!,
        repWeightList: [Tuple(4, 10)],
      ),
    ],
  );
}
