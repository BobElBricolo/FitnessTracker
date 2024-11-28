import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/helpers/creation_helper.dart';
import 'package:fitness_tracker/helpers/helpers.dart';
import 'package:fitness_tracker/models/exercise.dart';
import 'package:fitness_tracker/models/workout.dart';
import 'package:fitness_tracker/models/workout_exercise.dart';
import 'package:fitness_tracker/pages/workout_details/workout_details.dart';
import 'package:flutter/material.dart';

class RecentActivities extends StatefulWidget {
  const RecentActivities({super.key});

  @override
  State<RecentActivities> createState() => _RecentActivitiesState();
}

class _RecentActivitiesState extends State<RecentActivities> {
  // Liste des workouts gérée localement
  List<Workout> workoutList = [];

  @override
  void initState() {
    super.initState();
    _loadWorkouts(); // Charger les workouts à l'initialisation
  }

  // Charger les workouts depuis CreationHelper
  Future<void> _loadWorkouts() async {
    final workouts = await CreationHelper.getWorkouts();
    setState(() {
      workoutList = workouts;
    });
  }

  // Ajouter un workout
  void addWorkout() async {
  final newWorkout = Workout(
    name: "New Day",
    date: DateTime.now(),
    workoutImage: 'assets/Cardio.jpg',
    time: 45,
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

  // Ajouter le workout via CreationHelper
  await CreationHelper.addWorkout(newWorkout);

  // Recharger la liste des workouts
  await _loadWorkouts();
}


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Workouts',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: workoutList.isEmpty
                  ? const Center(child: Text('No workouts found'))
                  : ListView.builder(
                      itemCount: workoutList.length + 1, // Ajouter 1 pour inclure le bouton "+"
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // Première tuile : bouton "+"
                          return AddWorkoutTile(onAddWorkout: addWorkout);
                        }

                        // Autres tuiles : Workouts existants
                        return ActivityItem(
                          activity: workoutList[index - 1], // Décalage de 1 à cause du bouton "+"
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}


class ActivityItem extends StatelessWidget {
  final Workout activity; 

  const ActivityItem({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: ColorsHelper.cardColor, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkoutDetailPage(workout: activity)
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: ClipOval(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    activity.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                activity.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Row(
                children: [
                  const Icon(Icons.timer, size: 16, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(
                    formatMinutesToHours(activity.time),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(width: 15),
                  const Icon(Icons.fitness_center,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(
                    '${activity.exercises.length} exercises',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 24,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddWorkoutTile extends StatelessWidget {
  final VoidCallback onAddWorkout;

  const AddWorkoutTile({super.key, required this.onAddWorkout});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: ColorsHelper.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onAddWorkout,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 24, color: Colors.grey.withOpacity(0.5)),
              const SizedBox(width: 10),
              Text(
                'Add Workout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


