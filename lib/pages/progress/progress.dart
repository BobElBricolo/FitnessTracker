import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/pages/progress/comparing.dart';
import 'package:fitness_tracker/pages/progress/grid/calendar/calender.dart';
import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  const Progress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsHelper.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Progress',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: ColorsHelper.textColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorsHelper.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Calendar(),
            Comparing(),
          ],
        ),
      ),
    );
  }
}
