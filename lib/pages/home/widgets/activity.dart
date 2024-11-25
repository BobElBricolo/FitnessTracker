import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/helpers/creation_helper.dart';
import 'package:fitness_tracker/models/workout.dart';
import 'package:flutter/material.dart';

class RecentActivities extends StatelessWidget {
  RecentActivities({super.key});

  final Future<List<Workout>> workouts = getDefaultWorkout();

//List of activities with their details
  static List<ActivityForTile> activities = [
    const ActivityForTile(
        image: 'assets/Strength.jpg',
        title: 'Workout',
        duration: '30 min',
        caloriesBurnt: '23 sets'),
    const ActivityForTile(
        image: 'assets/Pull-Up.jpg',
        title: 'Pull-Up',
        duration: '20 min',
        caloriesBurnt: '23 sets'),
    const ActivityForTile(
        image: 'assets/Gym.jpg',
        title: 'Squats',
        duration: '23 sets',
        caloriesBurnt: '25Kcal'),
    const ActivityForTile(
        image: 'assets/Yoga.jpg',
        title: 'Plank',
        duration: '23 sets',
        caloriesBurnt: '15Kcal'),
    const ActivityForTile(
        image: 'assets/Cardio.jpg',
        title: 'Running',
        duration: '45 min',
        caloriesBurnt: '23 sets'),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Activities',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: activities.length,
                        itemBuilder: (context, index) => ActivityItem(activity: activities[index],)))
              ],
            )));
  }
}

class ActivityItem extends StatelessWidget {
  final ActivityForTile activity; 

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
          // Naviguez ou exécutez une action spécifique
          // Navigator.pushNamed(context, '/details');
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
                activity.title,
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
                    activity.duration,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(width: 15),
                  const Icon(Icons.fitness_center,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(
                    activity.caloriesBurnt,
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


// Class ativity with details
class ActivityForTile {
  final String image;
  final String title;
  final String duration;
  final String caloriesBurnt;

  const ActivityForTile({required this.image, required this.title, required this.duration, required this.caloriesBurnt});
}
