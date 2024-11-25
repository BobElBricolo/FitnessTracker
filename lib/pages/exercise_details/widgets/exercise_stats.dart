import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:flutter/material.dart';

class ExerciseStats extends StatelessWidget {
  final String equipment;
  final String level;
  final String category;
  final String oneRepMax;

  const ExerciseStats({
    super.key,
    required this.equipment,
    required this.level,
    required this.category,
    required this.oneRepMax,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Row(
            children: [
              Text(
                'Exercise Stats',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: ColorsHelper.textColor),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.bar_chart_outlined,
                size: 15,
                color: ColorsHelper.primaryColor,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InfoStat(
                      icon: Icons.category_outlined,
                      iconColor: const Color(0xff535bed),
                      iconBackgroundColor: const Color(0xffe4e7ff),
                      label: "Category",
                      value: category,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: InfoStat(
                      icon: Icons.fitness_center_outlined,
                      iconColor: const Color(0xffe11e6c),
                      iconBackgroundColor: const Color(0xffffe4fb),
                      label: "Equipment",
                      value: equipment,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InfoStat(
                      icon: Icons.trending_up,
                      iconColor: const Color(0xffd3b50f),
                      iconBackgroundColor: const Color.fromARGB(253, 240, 232, 190),
                      label: "Level",
                      value: level,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: InfoStat(
                      icon: Icons.sports_score,
                      iconColor: const Color(0xff3bc6fa),
                      iconBackgroundColor: const Color(0xffe4f7ff),
                      label: "One Rep Max",
                      value: oneRepMax,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InfoStat extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String label;
  final String value;

  const InfoStat({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: ColorsHelper.cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: ColorsHelper.cardBorderColor,
        ),
        boxShadow: const [
          BoxShadow(
            color: ColorsHelper.cardShadowColor,
            blurRadius: 3,
            offset: Offset(3, 3),
          )
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 15,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 10),
                ),
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
