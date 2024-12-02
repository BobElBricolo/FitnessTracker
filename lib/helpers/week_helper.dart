import 'package:fitness_tracker/helpers/creation_helper.dart';
import 'package:fitness_tracker/models/workout.dart';

class WeekHelper {
  Future<List<int>> getWorkoutDaysThisWeek() async {
    final thisWeekWorkouts = await getWeekWorkouts();
    final daysWorked = <int>{};
    for (final workout in thisWeekWorkouts) {
      daysWorked.add(_getDayOfWeekAsInt(workout.date));
    }

    return daysWorked.toList()..sort();
  }

  int _getDayOfWeekAsInt(DateTime date) {
    return (date.weekday) % 7;
  }

  Future<Map<String, int>> getMuscleWorkloadThisWeek() async {
    final thisWeekWorkouts = await getWeekWorkouts();

    final muscleWorkload = <String, int>{};

    for (final workout in thisWeekWorkouts) {
      for (final exercise in workout.exercises) {
        for (final muscle in exercise.exercise.primaryMuscles) {
          final workload = exercise.repWeightList
              .fold<int>(0, (sum, tuple) => sum + (tuple.set));
          _addToMuscleGroup(muscleWorkload, muscle, workload);
        }

        for (final muscle in exercise.exercise.secondaryMuscles) {
          final workload = exercise.repWeightList.fold<int>(
              0, (sum, tuple) => sum + ((tuple.set) * 0.5).toInt());
          _addToMuscleGroup(muscleWorkload, muscle, workload);
        }
      }
    }

    return muscleWorkload;
  }

  void _addToMuscleGroup(
      Map<String, int> muscleWorkload, String muscle, int workload) {
    const backMuscles = {'lower back', 'middle back', 'lats', 'traps'};

    if (backMuscles.contains(muscle)) {
      muscleWorkload['back'] = (muscleWorkload['back'] ?? 0) + workload;
    } else {
      muscleWorkload[muscle] = (muscleWorkload[muscle] ?? 0) + workload;
    }
  }

  double getTotalWeekStats() {
    return 0.0;
  }


  Future<List<Workout>> getWeekWorkouts() async {
    var workouts = await getDefaultWorkout();

    final now = DateTime.now();
    final sunday = DateTime(
      now.year,
      now.month,
      now.day - (now.weekday % 7),
    );

    final thisWeekWorkouts = workouts.where((workout) {
      return workout.date.isAfter(sunday) &&
          workout.date.isBefore(now.add(const Duration(days: 1)));
    }).toList();

    return thisWeekWorkouts;
  }
}
