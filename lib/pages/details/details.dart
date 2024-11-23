import 'package:fitness_tracker/pages/details/widgets/appbar.dart';
import 'package:fitness_tracker/pages/details/widgets/graph.dart';
import 'package:fitness_tracker/pages/details/widgets/info.dart';
import 'package:fitness_tracker/pages/details/widgets/stats.dart';
import 'package:flutter/material.dart';

import 'widgets/dates.dart';
import 'widgets/steps.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(appBar: AppBar(),),
      body: Column(
        children: [
          const Dates(),
          const Steps(),
          const Graph(),
          const Info(),
          Divider(height: 30, thickness: 1, color: Colors.grey[300]),
          const Stats(),
          const SizedBox(height: 30),
        ],
      ),    );
  }
}
