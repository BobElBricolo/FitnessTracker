import 'package:fitness_tracker/helpers/helpers.dart';
import 'package:flutter/material.dart';

class TotalLifted extends StatelessWidget {
  const TotalLifted({super.key});

  @override
  Widget build(BuildContext context) {

    //Random number for steps
    String steps = formatNumber(randBetween(0, 20000));

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Text(
              '$steps lbs',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            const Text(
              'Total weight lifted',
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w500, height: 2),
            ),
          ],
        ));
  }
}
