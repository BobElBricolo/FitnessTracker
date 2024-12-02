import 'dart:math';

import 'package:fitness_tracker/helpers/creation_helper.dart';
import 'package:fitness_tracker/models/workout.dart';
import 'package:fitness_tracker/models/workout_exercise.dart';

// Map of days of the week to their respective short form
final Map<int, String> daysOfWeek = {
  1: 'Mon',
  2: 'Tue',
  3: 'Wed',
  4: 'Thu',
  5: 'Fri',
  6: 'Sat',
  7: 'Sun',
};

// Create a random number between min and max
int randBetween(int min, int max) {
  return min + Random().nextInt(max - min);
}

// Format a number to a string with , every 3 digits (e.g. 1000 -> 1,000)
String formatNumber(int number) {
  return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}

String getMuscleImage(String muscle) {
  const backMuscles = [
    'lats',
    'middle back',
    'traps',
    'neck',
    'back',
    'upper back',
    'lower back'
  ];
  const legMuscles = [
    'quadriceps',
    'hamstrings',
    'glutes',
    'adductors',
    'abductors',
    'calves'
  ];
  const absMuscles = ['abdominals'];
  const armMuscles = ['triceps', 'biceps', 'forearms'];
  const chestMuscles = ['chest', 'shoulders'];
  const cardio = ['cardiovascular_system'];

  if (backMuscles.contains(muscle)) {
    return 'assets/exercises_logo/Back.jpg';
  } else if (legMuscles.contains(muscle)) {
    return 'assets/exercises_logo/Legs.jpg';
  } else if (absMuscles.contains(muscle)) {
    return 'assets/exercises_logo/Abs.jpeg';
  } else if (armMuscles.contains(muscle)) {
    return 'assets/exercises_logo/Arms.jpg';
  } else if (chestMuscles.contains(muscle)) {
    return 'assets/exercises_logo/Chest.jpg';
  } else if (cardio.contains(muscle)) {
    return 'assets/exercises_logo/Cardio.jpg';
  }

  return 'assets/exercises_logo/Default.jpg';
}

// Return dictionary with the name of the muscle group and the muscles in that group
Map<String, List<String>> getMuscleGroups() {
  return {
    'Back': [
      'lats',
      'middle back',
      'traps',
      'neck',
      'back',
      'upper back',
      'lower back'
    ],
    'Legs': [
      'quadriceps',
      'hamstrings',
      'glutes',
      'adductors',
      'abductors',
      'calves'
    ],
    'Abs': ['abdominals'],
    'Arms': ['triceps', 'biceps', 'forearms'],
    'Chest': ['chest', 'shoulders'],
    'Cardio': ['cardiovascular_system'],
  };
}

String formatMinutesToHours(int totalMinutes) {
  int hours = totalMinutes ~/ 60;
  int minutes = totalMinutes % 60;
  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}

// get the 1 rep max for a given weight and number of reps
double calculateOneRepMax(double weight, int reps) {
  return weight * (36 / (37 - reps));
}

// get the weight for a given 1 rep max and number of reps
double calculateWeightForReps(double oneRepMax, int reps) {
  return oneRepMax * (37 - reps) / 36;
}

Future<double> calculateOneRepMaxForExercise(String exerciseId) async {
  List<Workout> workouts = await getDefaultWorkout();
  double maxOneRep = 0;

  var workoutsWithExo =  workouts.where((workout) => workout.exercises.any((workoutExercise) => workoutExercise.exercise.id == exerciseId));


  for (Workout workout in workoutsWithExo) {
    for (WorkoutExercise workoutExercise in workout.exercises) {
      if (workoutExercise.exercise.id == exerciseId) {
        for (var repWeight in workoutExercise.repWeightList) {
          double weight = repWeight.weight;
          int reps = repWeight.set;
          double currentOneRepMax = calculateOneRepMax(weight, reps);
          if (currentOneRepMax > maxOneRep) {
            maxOneRep = currentOneRepMax;
          }
        }
      }
    }
  }

  return maxOneRep;
}

// Get exercise history for a given exercise within all workouts
Future<List<Map<String, dynamic>>> getExerciseHistory(String exerciseId) async {
  List<Workout> workouts = await getDefaultWorkout();
  List<Map<String, dynamic>> history = [];

  var workoutsWithExo =  workouts.where((workout) => workout.exercises.any((workoutExercise) => workoutExercise.exercise.id == exerciseId));

  for (Workout workout in workoutsWithExo) {
    for (WorkoutExercise workoutExercise in workout.exercises) {
      if (workoutExercise.exercise.id == exerciseId) {
        for (var repWeight in workoutExercise.repWeightList) {
          history.add({
            'date': workout.date,
            'weight': repWeight.weight,
            'reps': repWeight.set,
            'sets': workoutExercise.repWeightList.length,
          });
        }
      }
    }
  }

  return history;
}



// Format one rep max to a string with , every 3 digits (e.g. 1000 -> 1,000) and add 'kg' at the end
String formatOneRepMax(double oneRepMax) {
  var weightType = 'lbs';
  return '${formatNumber(oneRepMax.toInt())} $weightType';
}




