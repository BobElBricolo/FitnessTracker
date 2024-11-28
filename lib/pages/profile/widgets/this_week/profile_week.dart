import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/helpers/week_helper.dart';
import 'package:fitness_tracker/pages/profile/widgets/this_week/lifted_stats.dart';
import 'package:fitness_tracker/pages/profile/widgets/this_week/total_lifted.dart';
import 'package:fitness_tracker/pages/profile/widgets/this_week/week_dates.dart';
import 'package:fitness_tracker/pages/progress/duck.dart';
import 'package:flutter/material.dart';

class ProfileWeekCard extends StatelessWidget {
  const ProfileWeekCard({super.key});

  Future<Map<String, Color>> _calculateMuscleColors() async {
    final muscleWorkload = await WeekHelper().getMuscleWorkloadThisWeek();

    // Print each muscle and its workload
    muscleWorkload.forEach((muscle, workload) {
      print('$muscle: $workload');
    });

    if (muscleWorkload.isEmpty) return {};

    final maxWorkload = muscleWorkload.values.reduce((a, b) => a > b ? a : b);

    return muscleWorkload.map((muscle, workload) {
      final opacity = (workload / maxWorkload).clamp(0.2, 1.0); 
      return MapEntry(muscle, ColorsHelper.primaryColor.withOpacity(opacity));
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, Color>>(
      future: _calculateMuscleColors(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        }

        final muscleColors = snapshot.data ?? {};

        return Card(
          margin: const EdgeInsets.only(bottom: 22, left: 22, right: 22),
          elevation: 5,
          color: ColorsHelper.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'This Week',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.event,
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const WeekDates(),
                const SizedBox(height: 20),
                Duck(
                  duckColor: ColorsHelper.backgroundColor,
                  backColor: muscleColors['back'],
                  chestColor: muscleColors['chest'],
                  quadsColor: muscleColors['quadriceps'],
                  harmstringColor: muscleColors['hamstrings'],
                  calvesColor: muscleColors['calves'],
                  absColor: muscleColors['abdominals'],
                  forearmsColor: muscleColors['forearms'],
                  shouldersColor: muscleColors['shoulders'],
                  tricepsColor: muscleColors['triceps'],
                  bicepsColor: muscleColors['biceps'],
                  glutesColor: muscleColors['glutes'],
                ),
                const TotalLifted(),
                const InfoLifts(),
              ],
            ),
          ),
        );
      },
    );
  }
}
