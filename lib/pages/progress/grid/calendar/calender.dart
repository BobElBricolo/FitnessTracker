import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/pages/progress/grid/grid.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => CalenderState();
}

class CalenderState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 22, left: 22, right: 22),
      elevation: 5,
      color: ColorsHelper.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorsHelper.cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top:15.0, bottom: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Last Month',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.calendar_month,
                    size: 24,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 190,
              child: Padding(padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),  
               child: GymDaysGrid(
                startDate: DateTime.now().subtract(const Duration(days: 28)),
              ),)
            ),
          ],
        ),
      ),
    );
  }
}
