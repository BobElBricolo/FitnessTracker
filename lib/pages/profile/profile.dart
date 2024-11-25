import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/pages/profile/widgets/profile_badges.dart';
import 'package:fitness_tracker/pages/profile/widgets/profile_level.dart';
import 'package:fitness_tracker/pages/profile/widgets/this_week/profile_week.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsHelper.backgroundColor,
        appBar: AppBar(
          backgroundColor: ColorsHelper.backgroundColor,
          title: const Text(
            "Profile",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: ColorsHelper.textColor),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileLevelCard(),
              const ProfileWeekCard(),
              ProfileBadges()
            ],
          ),
        ));
  }
}
