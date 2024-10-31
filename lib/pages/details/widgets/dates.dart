import 'package:fitness_tracker/helpers.dart';
import 'package:flutter/material.dart';

class Dates extends StatelessWidget {
  const Dates({super.key});

  @override
  Widget build(BuildContext context) {

    List<DateBox> datesBoxes =[];

    for (int i = 0; i < 6; i++) {
      DateTime date = DateTime.now().add(Duration(days: i - 3));
      datesBoxes.add(DateBox(date: date, isActived: i == 3));
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: datesBoxes,
      ),
    );
  }
}

class DateBox extends StatelessWidget {
  final bool isActived;
  final DateTime date;

  const DateBox({super.key, required this.date, this.isActived = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      decoration: BoxDecoration(
        gradient: isActived
            ? const LinearGradient(
                colors: [Color(0xff92e2ff), Color(0xff1ebdf8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
        border: Border.all(color: const Color(0xffe1e1e1)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DefaultTextStyle.merge(
        style: isActived
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
        child: Column(
          children: [
            Text(
              daysOfWeek[date.weekday].toString(),
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              date.day.toString().padLeft(2,'0'),
              style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
