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
  late List<Workout> workouts;

  @override
  void initState() {
    super.initState();
    // Récupère la liste de workouts par défaut
    workouts = getDefaultWorkout();
  }

  @override
  Widget build(BuildContext context) {
    // Extraire les jours de workout
    final workoutDays = workouts
        .map((workout) => DateTime(workout.date.year, workout.date.month, workout.date.day))
        .toSet();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // Une semaine avec 7 jours
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
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
    return Container(
      width: 60, // Largeur totale du carré
      height: 60, // Hauteur totale du carré
      decoration: BoxDecoration(
        color: wentToGym ? Colors.orangeAccent : Colors.transparent, // Fond orange-jaune si allé au gym
        borderRadius: BorderRadius.circular(8), // Coins arrondis pour le carré
        border: Border.all(
          color: Colors.grey, // Couleur du contour
          width: 1, // Épaisseur du contour
        ),
      ),
      child: Center(
        child: ClipOval(
          child: Image.asset(
            wentToGym
                ? 'assets/progress/grid/crackedEgg.png' // Image si la personne est allée au gym
                : 'assets/progress/grid/egg.png', // Image sinon
            width: 50, // Diamètre du cercle
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
