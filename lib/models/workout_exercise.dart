import 'exercise.dart';

class WorkoutExercise {
  final Exercise exercise;

  // List of tuples
  final List<Tuple<int, double>> repWeightList;

  get sets => repWeightList.length;

  WorkoutExercise({
    required this.exercise,
    required this.repWeightList,
  });
}

class Tuple<T1, T2> {
  final T1 set;
  final T2 weight;

  Tuple(this.set, this.weight);
}
