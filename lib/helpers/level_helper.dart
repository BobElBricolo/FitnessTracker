import 'package:fitness_tracker/helpers/helpers.dart';

/// Enumération des niveaux de fitness
enum FitnessLevel {
  beginner,
  intermediate,
  advanced,
  pro,
}

extension FitnessLevelExtension on FitnessLevel {
  String get name {
    switch (this) {
      case FitnessLevel.beginner:
        return 'Beginner';
      case FitnessLevel.intermediate:
        return 'Intermediate';
      case FitnessLevel.advanced:
        return 'Advanced';
      case FitnessLevel.pro:
        return 'Pro';
    }
  }
}

/// Classe pour calculer les niveaux de fitness
class FitnessLevelCalculator {
  /// Détermine le niveau basé sur les seuils
  FitnessLevel? _getFitnessLevel(double oneRepMax, List<double> thresholds) {
    if (oneRepMax == 0) {
      return null;
    } else if (oneRepMax < thresholds[0]) {
      return FitnessLevel.beginner;
    } else if (oneRepMax <= thresholds[1]) {
      return FitnessLevel.intermediate;
    } else if (oneRepMax <= thresholds[2]) {
      return FitnessLevel.advanced;
    } else {
      return FitnessLevel.pro;
    }
  }

  FitnessLevel? getBenchPressLevel(double oneRepMax) {
    return _getFitnessLevel(oneRepMax, [135, 225, 315]);
  }

  FitnessLevel? getInclineBenchPressLevel(double oneRepMax) {
    return _getFitnessLevel(oneRepMax, [115, 185, 275]);
  }

  FitnessLevel? getSquatLevel(double oneRepMax) {
    return _getFitnessLevel(oneRepMax, [135, 225, 315]);
  }

  FitnessLevel? getLegPressLevel(double oneRepMax) {
    return _getFitnessLevel(oneRepMax, [225, 405, 585]);
  }

  FitnessLevel? getBarbellRowLevel(double oneRepMax) {
    return _getFitnessLevel(oneRepMax, [95, 175, 275]);
  }

  FitnessLevel? getDeadliftLevel(double oneRepMax) {
    return _getFitnessLevel(oneRepMax, [185, 315, 450]);
  }

  Future<FitnessLevel?> getBackLevel() async {
    final deadliftOneRepMax =
        await calculateOneRepMaxForExercise('Barbell_Deadlift');
    final barbellRowOneRepMax =
        await calculateOneRepMaxForExercise('Bent_Over_Barbell_Row');

    if (deadliftOneRepMax != 0) {
      return getDeadliftLevel(deadliftOneRepMax);
    } else if (barbellRowOneRepMax != 0) {
      return getBarbellRowLevel(barbellRowOneRepMax);
    } else {
      return null;
    }
  }

  Future<FitnessLevel?> getChestLevel() async {
    final benchPressOneRepMax = await calculateOneRepMaxForExercise(
        'Barbell_Bench_Press_-_Medium_Grip');
    final inclineBenchPressOneRepMax = await calculateOneRepMaxForExercise(
        'Barbell_Incline_Bench_Press_-_Medium_Grip');

    if (benchPressOneRepMax != 0) {
      return getBenchPressLevel(benchPressOneRepMax);
    } else if (inclineBenchPressOneRepMax != 0) {
      return getInclineBenchPressLevel(inclineBenchPressOneRepMax);
    } else {
      return null;
    }
  }

  Future<FitnessLevel?> getLegsLevel() async {
    final squatOneRepMax =
        await calculateOneRepMaxForExercise('Barbell_Full_Squat');
    final legPressOneRepMax = await calculateOneRepMaxForExercise('Leg_Press');

    if (squatOneRepMax != 0) {
      return getSquatLevel(squatOneRepMax);
    } else if (legPressOneRepMax != 0) {
      return getLegPressLevel(legPressOneRepMax);
    } else {
      return null;
    }
  }

  Future<FitnessLevel?> getUserMainLevel() async {
    final backLevel = await getBackLevel() as FitnessLevel?;
    final chestLevel = await getChestLevel();
    final legsLevel = await getLegsLevel();

    if (backLevel == null && chestLevel == null && legsLevel == null) {
      return null;
    }

    final levelMapping = {
      "Beginner": 1,
      "Intermediate": 2,
      "Advanced": 3,
      "Pro": 4
    };

    // map the level to the corresponding index
    final backLevelIndex = backLevel != null ? levelMapping[backLevel.name]!: 0;
    final chestLevelIndex = chestLevel != null ? levelMapping[chestLevel.name]! : 0;
    final legsLevelIndex = legsLevel != null ? levelMapping[legsLevel.name]! : 0;

    // return la moyenne des niveaux
    final averageLevel = (backLevelIndex + chestLevelIndex + legsLevelIndex) / 3;

    return averageLevel.round() == 0
        ? null
        : FitnessLevel.values[averageLevel.round() - 1];

}}