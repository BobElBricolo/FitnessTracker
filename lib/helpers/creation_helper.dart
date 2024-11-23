import 'package:fitness_tracker/models/exercise.dart';
import 'package:fitness_tracker/models/workout.dart';
import 'package:fitness_tracker/models/workout_exercise.dart';

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

Exercise? findExerciseById(String id) {
  return getDefaultExercise().firstWhere(
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

List<Workout> getDefaultWorkout() {
  return [
    Workout(
      name: "Push Day",
      date: DateTime.now().subtract(const Duration(days: 10)),
      exercises: [
        WorkoutExercise(
          exercise: findExerciseById("bench_press")!,
          sets: 4,
          reps: 10,
          weight: 80,
        ),
        WorkoutExercise(
          exercise: findExerciseById("shoulder_press")!,
          sets: 3,
          reps: 12,
          weight: 20,
        ),
      ],
    ),
    Workout(
      name: "Pull Day",
      date: DateTime.now().subtract(const Duration(days: 9)),
      exercises: [
        WorkoutExercise(
          exercise: findExerciseById("deadlift")!,
          sets: 4,
          reps: 8,
          weight: 120,
        ),
      ],
    ),
    Workout(
      name: "Leg Day",
      date: DateTime.now().subtract(const Duration(days: 7)),
      exercises: [
        WorkoutExercise(
          exercise: findExerciseById("squat")!,
          sets: 4,
          reps: 10,
          weight: 100,
        ),
        WorkoutExercise(
            exercise: findExerciseById("bench_press")!,
            sets: 4,
            reps: 15,
            weight: 135),
        WorkoutExercise(
          exercise: findExerciseById("deadlift")!,
          sets: 4,
          reps: 8,
          weight: 150,
        ),
WorkoutExercise(
            exercise: findExerciseById("bench_press")!,
            sets: 5,
            reps: 4,
            weight: 220),      ],
    ),
    Workout(
      name: "Cardio",
      date: DateTime.now().subtract(const Duration(days: 4)),
      exercises: [
        WorkoutExercise(
          exercise: findExerciseById("running")!,
          sets: 1,
          reps: 1,
          weight: 0,
        ),
      ],
    ),
  ];
}
