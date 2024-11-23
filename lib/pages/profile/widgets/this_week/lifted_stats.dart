import 'package:flutter/material.dart';

class InfoLifts extends StatelessWidget {
  const InfoLifts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LiftsStatsLabel(value: '1,200', unit: 'sets'),
        LiftsStatsLabel(value: '3.6', unit: 'reps'),
        LiftsStatsLabel(value: '1.5', unit: 'hr'),
      ],
    );
  }
}

class LiftsStatsLabel extends StatelessWidget {
  final String value;
  final String unit;

  const LiftsStatsLabel(
      {super.key,
      required this.value,
      required this.unit});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: 10),
     child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(TextSpan(
          text: value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          children: [
            const TextSpan(
              text: ' ',
            ),
            TextSpan(
              text: ' $unit',
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ),
          ],
        )),
      ],
    ),);
  }
}
