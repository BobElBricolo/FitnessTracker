import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/models/badge.dart';
import 'package:flutter/material.dart';

class ProfileBadges extends StatelessWidget {
  final int badgeCount = WorkoutBadge.getBadges().length;
  final List<WorkoutBadge> foundBadges = WorkoutBadge.getBadges()
      .where((element) => element.isCompleted() == true)
      .toList();

  ProfileBadges({super.key});

  void _showBadgeDescription(BuildContext context, WorkoutBadge badge) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(badge.name),
          content: Text(badge.description),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Organiser les badges en lignes
    List<Widget> rows = [];
    for (int i = 0; i < badgeCount; i += 3) {
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            3,
            (j) {
              int index = i + j;
              if (index >= badgeCount) return const SizedBox.shrink();

              bool isFound = index < foundBadges.length;

              return GestureDetector(
                onTap: () {
                  if (isFound) {
                    _showBadgeDescription(context, foundBadges[index]);
                  }
                },
                child: Container(
                  width: 90,
                  height: 70,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFound ? Colors.black : Colors.grey,
                  ),
                  child: ClipOval(
                    child: isFound
                        ? Image.asset(
                            foundBadges[index].iconPath,
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Text(
                              "?",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    return Card(
      color: ColorsHelper.cardColor,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Badges',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
               SizedBox(width: 8),
               Icon(
                Icons.emoji_events_outlined,
                size: 24,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: rows,
            ),
          ),
        ],
      ),
    );
  }
}
