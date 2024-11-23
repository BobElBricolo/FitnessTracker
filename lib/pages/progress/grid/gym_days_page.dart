import 'package:flutter/material.dart';

import 'grid.dart';

class GymDaysPage extends StatelessWidget {
  const GymDaysPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prgress'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GymDaysGrid(
          startDate: DateTime.now()
              .subtract(const Duration(days: 28)), // Commence il y a 30 jours
        ),
      ),
    );
  }
}
