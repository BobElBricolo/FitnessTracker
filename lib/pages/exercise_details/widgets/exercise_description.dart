import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:flutter/material.dart';

class DescriptionCard extends StatelessWidget {
  final String title;
  final List<String> instructions;

  const DescriptionCard({
    super.key,
    required this.title,
    required this.instructions,
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
                'Description',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: ColorsHelper.textColor),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.description_outlined,
                size: 15,
                color: ColorsHelper.primaryColor,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            decoration: BoxDecoration(
              color: ColorsHelper.cardColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: ColorsHelper.cardBorderColor),
              boxShadow: const [
                BoxShadow(
                  color: ColorsHelper.cardShadowColor,
                  blurRadius: 3,
                  offset: Offset(3, 3),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: instructions.map((step) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('•', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            step,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
