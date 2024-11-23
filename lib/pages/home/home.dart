import 'package:fitness_tracker/pages/home/widgets/activity.dart';
import 'package:fitness_tracker/pages/home/widgets/current.dart';
import 'package:flutter/material.dart';

import 'widgets/header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [
        AppHeader(),
        CurrentPrograms(),
        RecentActivities(),
      ],
    ),
    );
  }
}
