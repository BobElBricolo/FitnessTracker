import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatsLabel(value: '1,200', unit: 'kcal', label: 'Calories'),
        StatsLabel(value: '3.6', unit: 'km', label: 'Distance'),
        StatsLabel(value: '1.5', unit: 'hr', label: 'Hours'),
      ],
    );
  }
}

class StatsLabel extends StatelessWidget {
  final String value;
  final String unit;
  final String label;

  const StatsLabel(
      {super.key,
      required this.value,
      required this.unit,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Text(
          label,
          style:
              const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, height: 2),
        ),
      ],
    );
  }
}
