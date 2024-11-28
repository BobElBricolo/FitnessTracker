import 'workout_exercise.dart';

class Workout {
  final String name;
  final DateTime date;
  final List<WorkoutExercise> exercises;
  final int time;
  final bool isPreset;
  String? workoutImage;


  Workout({
    required this.name,
    required this.date,
    required this.exercises,
    required this.time,
    this.workoutImage,
    this.isPreset =false,
  });

  
// Return the image associated with the workout based on the most worked muscle
  String get image {
    if (workoutImage != null) {
      return workoutImage!;
    }

    final muscleCounts = <String, int>{};

    for (var exercise in exercises) {
      for (var muscle in exercise.exercise.primaryMuscles) {
        muscleCounts[muscle] = (muscleCounts[muscle] ?? 0) + 1;
      }
    }

    final mostWorkedMuscle =
        muscleCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    return _getMuscleImage(mostWorkedMuscle);
  }

// Return the type of workout based on the most common category
  String get type {
    final categoryCounts = <String, int>{};

    for (var exercise in exercises) {
      final category = exercise.exercise.category;
      categoryCounts[category] = (categoryCounts[category] ?? 0) + 1;
    }

    return categoryCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

// Return the image associated with the muscle
  String _getMuscleImage(String muscle) {
    const muscleImageMap = {
      'back': ['lats', 'middle_back', 'traps', 'lower_back'],
      'legs': ['quadriceps', 'hamstrings', 'glutes'],
      'chest': ['chest'],
      'arms': ['biceps', 'triceps', 'forearms'],
      'shoulders': ['shoulders'],
      'abs': ['abdominals'],
      'cardio': ['cardiovascular_system'],
    };

//TODO: Ajouter des images pour les groupes musculaires restants
    const muscleImages = {
      'back': 'assets/Pull-Up.jpg',
      'legs': 'assets/Gym.jpg',
      'chest': 'assets/Gym.jpg',
      'arms': 'assets/Strength.jpg',
      'shoulders': 'assets/Strength.jpg',
      'abs': 'assets/Yoga.jpg',
      'cardio': 'assets/Cardio.jpg',
    };

    for (var entry in muscleImageMap.entries) {
      if (entry.value.contains(muscle)) {
        return muscleImages[entry.key] ?? 'assets/Gym.jpg';
      }
    }

    return 'assets/Gym.jpg';
  }
}
