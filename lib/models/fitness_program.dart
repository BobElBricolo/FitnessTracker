import 'package:flutter/material.dart';

enum ProgramType {
  strength,
  yoga,
  cardio,
}

class FitnessProgram {
  final String name;
  final AssetImage image;
  final String cals;
  final String duration;
  final ProgramType type;

  const FitnessProgram({
    required this.name,
    required this.image,
    required this.cals,
    required this.duration,
    required this.type,
  });

}



// List of fitness programs (dummy data later to be fetched from an API)
final List<FitnessProgram> fitnessPrograms = [
  const FitnessProgram(
    name: 'Full Body Workout',
    image: AssetImage('assets/Strength.jpg'),
    cals: '400',
    duration: '1h 30min',
    type: ProgramType.strength,
  ),
  const FitnessProgram(
    name: 'Yoga',
    image: AssetImage('assets/Yoga.jpg'),
    cals: '250',
    duration: '1h',
    type: ProgramType.yoga,
  ),
  const FitnessProgram(
    name: 'Cardio',
    image: AssetImage('assets/Cardio.jpg'),
    cals: '300',
    duration: '1h',
    type: ProgramType.cardio,
  ),
  const FitnessProgram(
    name: 'Strength Training',
    image: AssetImage('assets/Gym.jpg'),
    cals: '350',
    duration: '1h 30min',
    type: ProgramType.strength,
  ),
];
