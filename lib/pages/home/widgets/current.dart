import 'package:fitness_tracker/helpers/creation_helper.dart';
import 'package:fitness_tracker/helpers/helpers.dart';
import 'package:fitness_tracker/models/workout.dart';
import 'package:flutter/material.dart';

class CurrentPrograms extends StatefulWidget {
  const CurrentPrograms({super.key});

  @override
  State<CurrentPrograms> createState() => _CurrentProgramsState();
}

class _CurrentProgramsState extends State<CurrentPrograms> {
  late Future<List<Workout>> workouts;

  @override
  void initState() {
    super.initState();
    // Initialisation de la liste des workouts via un Future
    workouts = getDefaultWorkout();
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
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 100,
          child: FutureBuilder<List<Workout>>(
            future: workouts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator()); // Loader pendant le chargement
              } else if (snapshot.hasError) {
                return Center(child: Text('Erreur: ${snapshot.error}')); // Gestion des erreurs
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Aucun programme disponible')); // Liste vide
              }

              final workoutList = snapshot.data!;

              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 20,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                scrollDirection: Axis.horizontal,
                itemCount: workoutList.length,
                itemBuilder: (context, index) {
                  return ProgramWorkoutCard(
                    workout: workoutList[index],
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}

class ProgramWorkoutCard extends StatelessWidget {
  final Workout workout;

  const ProgramWorkoutCard({
    super.key,
    required this.workout,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black;

    return Container(
      height: 100,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(.6),
            BlendMode.lighten,
          ),
          image: AssetImage(workout.image),
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
              workout.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(workout.type),
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
                Text(formatMinutesToHours(workout.temps)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
