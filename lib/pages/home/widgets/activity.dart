import 'package:flutter/material.dart';

class RecentActivities extends StatelessWidget {
  const RecentActivities({super.key});

//List of activities with their details
  static List<ActivityForTile> activities = [
    const ActivityForTile(
        image: 'assets/Strength.jpg',
        title: 'Workout',
        duration: '30 min',
        caloriesBurnt: '55Kcal'),
    const ActivityForTile(
        image: 'assets/Pull-Up.jpg',
        title: 'Pull-Up',
        duration: '20 min',
        caloriesBurnt: '35Kcal'),
    const ActivityForTile(
        image: 'assets/Gym.jpg',
        title: 'Squats',
        duration: '15 min',
        caloriesBurnt: '25Kcal'),
    const ActivityForTile(
        image: 'assets/Yoga.jpg',
        title: 'Plank',
        duration: '10 min',
        caloriesBurnt: '15Kcal'),
    const ActivityForTile(
        image: 'assets/Cardio.jpg',
        title: 'Running',
        duration: '45 min',
        caloriesBurnt: '75Kcal'),
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
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/details');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffe1e1e1)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffcff2ff),
              ),
              height: 35,
              width: 35,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(activity.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Text(activity.title,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
            const Expanded(
              child: SizedBox(),
            ),
            const Icon(Icons.timer, size: 12),
            const SizedBox(width: 5),
            Text(activity.duration,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400)),
            const SizedBox(width: 12),
            const Icon(Icons.wb_sunny_outlined, size: 12),
            const SizedBox(width: 5),
            Text(activity.caloriesBurnt,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400)),
            const SizedBox(width: 20),
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
