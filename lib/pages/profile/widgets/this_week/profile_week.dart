import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/pages/profile/widgets/this_week/lifted_stats.dart';
import 'package:fitness_tracker/pages/profile/widgets/this_week/total_lifted.dart';
import 'package:fitness_tracker/pages/profile/widgets/this_week/week_dates.dart';
import 'package:flutter/material.dart';

class ProfileWeekCard extends StatelessWidget {
  const ProfileWeekCard({super.key});

  @override
  Widget build(BuildContext context) {
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
            Image.asset(
              'assets/progress/Canard-muscles.png',
              height: 300,
              width: 300,
            ),


            const TotalLifted(),
            const InfoLifts(),
          ],
        ),
      ),
    );
  }
}
