import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/helpers/creation_helper.dart';
import 'package:fitness_tracker/models/exercise.dart';
import 'package:fitness_tracker/models/workout.dart';
import 'package:fitness_tracker/models/workout_exercise.dart';
import 'package:fitness_tracker/pages/home/widgets/add_preset_card.dart';
import 'package:flutter/material.dart';

class PresetWorkouts extends StatefulWidget {
  const PresetWorkouts({super.key});

  @override
  State<PresetWorkouts> createState() => _PresetWorkoutsState();
}

class _PresetWorkoutsState extends State<PresetWorkouts> {
  late Future<List<Workout>> presetWorkouts;

  @override
  void initState() {
    super.initState();
    presetWorkouts = CreationHelper.getPresetWorkouts();
  }

  Future<void> addPreset() async {
    try {
      await CreationHelper.addWorkout(newWorkout);
      setState(() {
        // Recharge la liste des workouts
        presetWorkouts = CreationHelper.getPresetWorkouts();
      });
    } catch (e) {
      // Affiche un message d'erreur si nécessaire
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add workout: $e')),
      );
    }
  }

  final newWorkout = Workout(
    name: "New Preset",
    date: DateTime.now(),
    workoutImage: 'assets/Cardio.jpg',
    time: 45,
    isPreset: true,
    exercises: [
      WorkoutExercise(
        exercise: Exercise(
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
        repWeightList: [Tuple(3, 0)], // 3 sets, no weight
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Preset Workouts',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 100,
          child: FutureBuilder<List<Workout>>(
            future: presetWorkouts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('There are no workouts'));
              }

              final presetWorkoutList = snapshot.data!;

              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 20,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                scrollDirection: Axis.horizontal,
                itemCount: presetWorkoutList.length + 1,
                itemBuilder: (context, index) {
                  if (index == presetWorkoutList.length) {
                    // Carte pour ajouter un preset
                    return AddPresetCard(
                      onTap: () {
                        addPreset();
                      },
                    );
                  }

                  // Autres cartes normales
                  return ProgramWorkoutCard(
                    presetWorkout: presetWorkoutList[index],
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}

class ProgramWorkoutCard extends StatelessWidget {
  final Workout presetWorkout;

  const ProgramWorkoutCard({
    super.key,
    required this.presetWorkout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 120,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: ColorsHelper.cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: ColorsHelper.cardBorderColor,
        ),
        boxShadow: const [
          BoxShadow(
            color: ColorsHelper.cardShadowColor,
            blurRadius: 3,
            offset: Offset(3, 3),
          )
        ],
      ),
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.grey),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  presetWorkout.type,
                  style: const TextStyle(fontSize: 10),
                ),
                Text(
                  presetWorkout.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
