import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/helpers/creation_helper.dart';
import 'package:fitness_tracker/models/workout.dart';
import 'package:flutter/material.dart';

class GymDaysGrid extends StatefulWidget {
  final DateTime startDate;
  final int totalDays;

  const GymDaysGrid({
    super.key,
    required this.startDate,
    this.totalDays = 28,
  });

  @override
  GymDaysGridState createState() => GymDaysGridState();
}

class GymDaysGridState extends State<GymDaysGrid> {
  late Future<List<Workout>> workouts;

  @override
  void initState() {
    super.initState();
    // Récupère la liste de workouts par défaut
    workouts = getDefaultWorkout();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Workout>>(
      future: workouts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Affiche un loader pendant le chargement
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}')); // Affiche un message en cas d'erreur
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Aucun workout disponible')); // Affiche un message si la liste est vide
        }

        final workoutDays = snapshot.data!
            .map((workout) => DateTime(workout.date.year, workout.date.month, workout.date.day))
            .toSet();

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 0.1,
            mainAxisSpacing: 0.1,
          ),
          itemCount: widget.totalDays,
          itemBuilder: (context, index) {
            final day = widget.startDate.add(Duration(days: index));
            final wentToGym = workoutDays.contains(
              DateTime(day.year, day.month, day.day),
            );
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
            color: wentToGym ? ColorsHelper.primaryColor : ColorsHelper.cardBorderColor,
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
