import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/helpers/creation_helper.dart';
import 'package:fitness_tracker/models/workout.dart';
import 'package:flutter/material.dart';

class GymDaysGrid extends StatefulWidget {
  const GymDaysGrid({super.key});

  @override
  GymDaysGridState createState() => GymDaysGridState();
}

class GymDaysGridState extends State<GymDaysGrid> {
  late Future<List<Workout>> workouts;

  @override
  void initState() {
    super.initState();
    workouts = getDefaultWorkout();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final startDate = today.subtract(const Duration(days: 28));

    return FutureBuilder<List<Workout>>(
      future: workouts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Aucun workout disponible'));
        }

        final workoutDays = snapshot.data!
            .where((workout) =>
                workout.date.isAfter(startDate) &&
                workout.date.isBefore(today.add(const Duration(days: 1))))
            .map((workout) => DateTime(
                workout.date.year, workout.date.month, workout.date.day))
            .toSet();

        //Transform workoutDays to a list of int of the difference between the start date and the workout date
        List<int> workoutDaysInt = [];
        for (var element in workoutDays) {
          workoutDaysInt.add(element.difference(startDate).inDays);
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 0.1,
            mainAxisSpacing: 0.1,
          ),
          itemCount: 28,
          itemBuilder: (context, index) {
            final wentToGym = workoutDaysInt.contains(index);
            return GymDayCell(
              wentToGym: wentToGym,
            );
          },
        );
      },
    );
  }
}

class GymDayCell extends StatelessWidget {
  final bool wentToGym;

  const GymDayCell({
    super.key,
    required this.wentToGym,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: wentToGym
              ? const LinearGradient(
                  colors: [
                    ColorsHelper.primaryColorGradient,
                    ColorsHelper.primaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: !wentToGym ? ColorsHelper.cardColor : null,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: wentToGym
                ? ColorsHelper.primaryColor
                : ColorsHelper.cardBorderColor,
            width: 1,
          ),
        ),
        child: Center(
          child: ClipOval(
            child: Image.asset(
              wentToGym
                  ? 'assets/progress/grid/crackedEgg.png'
                  : 'assets/progress/grid/egg.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              color: wentToGym ? ColorsHelper.textColor : null,
            ),
          ),
        ),
      ),
    );
  }
}
