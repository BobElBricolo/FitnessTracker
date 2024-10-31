import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  const Stats({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(padding: EdgeInsets.only(left: 25), 
        child: 
        Row(
          children: [
            Text(
              'Workout Stats',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.pie_chart_rounded,
              size: 15,
              color: Color(0xff3bc6fa),
            ),
          ],
        ),),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: 25,
              ),
              InfoStat(
                  icon: Icons.timer_outlined,
                  iconColor: Color(0xff535bed),
                  iconBackgroundColor: Color(0xffe4e7ff),
                  time: "+5s",
                  value: "30:34",
                  label: "Time"),
              SizedBox(
                width: 15,
              ),
              InfoStat(
                  icon: Icons.favorite_outline,
                  iconColor: Color(0xffe11e6c),
                  iconBackgroundColor: Color(0xffffe4fb),
                  time: "+5s",
                  label: "Heart Rate",
                  value: "151bpm"),
              SizedBox(
                width: 15,
              ),
              InfoStat(
                  icon: Icons.bolt,
                  iconColor: Color(0xffd3b50f),
                  iconBackgroundColor: Color.fromARGB(253, 240, 232, 190),
                  time: "+5s",
                  label: "Energy",
                  value: "169kcal"),
              SizedBox(
                width: 25,
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
  final String time;

  const InfoStat(
      {super.key,
      required this.icon,
      required this.iconColor,
      required this.iconBackgroundColor,
      required this.label,
      required this.value,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 110,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xffe1e1e1),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: Offset(3, 3),
          )
        ],
      ),
      child: Stack(
        children: [
          StatIcon(
            icon: icon,
            iconColor: iconColor,
            iconBackgroundColor: iconBackgroundColor,
          ),
          Change(time: time),
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
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),

          //Text(label),
          //Text(value),
        ],
      ),
    );
  }
}

class StatIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;

  const StatIcon(
      {super.key,
      required this.icon,
      required this.iconColor,
      required this.iconBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class Change extends StatelessWidget {
  final String time;

  const Change({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topRight,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(500),
            ),
            child: Text(
              time,
              style: const TextStyle(fontSize: 10, color: Colors.white),
            )));
  }
}
