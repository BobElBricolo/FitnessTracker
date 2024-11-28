import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:flutter/material.dart';

class AddPresetCard extends StatelessWidget {
  final VoidCallback onTap;

  const AddPresetCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: 120,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: ColorsHelper.cardColor.withOpacity(0.95),
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
        child: Center(
          child: Icon(
            Icons.add,
            size: 40,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
