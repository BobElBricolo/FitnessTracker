import 'package:fitness_tracker/models/fitness_program.dart';
import 'package:flutter/material.dart';

class CurrentPrograms extends StatefulWidget {
  const CurrentPrograms({super.key});

  @override
  State<CurrentPrograms> createState() => _CurrentProgramsState();
}

class _CurrentProgramsState extends State<CurrentPrograms> {
  ProgramType isActived = fitnessPrograms[0].type;

  void _changeActiveProgram(ProgramType type) {
    setState(() {
      isActived = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current Programs',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ],
            )),
        SizedBox(
          width: double.infinity,
          height: 100,
          child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                    width: 20,
                  ),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              scrollDirection: Axis.horizontal,
              itemCount: fitnessPrograms.length,
              itemBuilder: (context, index) {
                return ProgramWorkoutCard(
                    fitnessProgram: fitnessPrograms[index],
                    isActived: fitnessPrograms[index].type == isActived,
                    onTap: _changeActiveProgram);
              }),
        )
      ],
    );
  }
}

class ProgramWorkoutCard extends StatelessWidget {
  final FitnessProgram fitnessProgram;
  final bool isActived;
  final Function(ProgramType) onTap;

  const ProgramWorkoutCard(
      {super.key, required this.fitnessProgram, this.isActived = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color textColor = isActived ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: () {onTap(fitnessProgram.type);},
      child: Container(
      height: 100,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              isActived
                  ? const Color(0xFF1edbf8).withOpacity(.8)
                  : Colors.white.withOpacity(.6),
              BlendMode.lighten),
          image: fitnessProgram.image,
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(15),
      child: DefaultTextStyle.merge(
          style: TextStyle(
            color: textColor,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                fitnessProgram.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(fitnessProgram.cals),
                  const SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.timer,
                    color: textColor,
                    size: 10,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(fitnessProgram.duration),
                ],
              )
            ],
          )),
    ),
    );
  }
}
