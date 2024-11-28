import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/helpers/helpers.dart';
import 'package:fitness_tracker/helpers/week_helper.dart';
import 'package:flutter/material.dart';

class WeekDates extends StatelessWidget {
  const WeekDates({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutTracker = WeekHelper();

    return FutureBuilder<List<int>>(
      future: workoutTracker.getWorkoutDaysThisWeek(), // Utiliser WorkoutTracker
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading workout days'));
        }

        final workedDays = snapshot.data ?? []; // Liste des jours travaillés

        List<WeekDatesBox> datesBoxes = [];

        // Ajouter les dates de la semaine en utilisant workedDays
        var weekday = DateTime.now().weekday;
        for (int i = 0; i < 7; i++) {
          DateTime date = DateTime.now().add(Duration(days: i - weekday));
          bool isWorked = workedDays.contains(i); // Vérifier si le jour est travaillé
          datesBoxes.add(WeekDatesBox(date: date, isWorked: isWorked));
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: datesBoxes,
        );
      },
    );
  }
}

class WeekDatesBox extends StatelessWidget {
  final bool isWorked;
  final DateTime date;

  const WeekDatesBox({super.key, required this.date, this.isWorked = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      decoration: BoxDecoration(
        gradient: isWorked
            ? const LinearGradient(
                colors: [ColorsHelper.primaryColorGradient, ColorsHelper.primaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
        border: Border.all(color: ColorsHelper.cardBorderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DefaultTextStyle.merge(
        style: isWorked
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
        child: Column(
          children: [
            Text(
              daysOfWeek[date.weekday].toString(),
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              date.day.toString().padLeft(2, '0'),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
