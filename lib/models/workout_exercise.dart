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
  final T1 item1;
  final T2 item2;

  Tuple(this.item1, this.item2);
}
