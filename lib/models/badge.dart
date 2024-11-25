class WorkoutBadge {
  final String name;
  final String description;
  final String objective;
  final String iconPath; // chemin vers l'image du badge
  final bool Function()
      isCompleted; // fonction qui retourne si le badge est complété

  WorkoutBadge({
    required this.name,
    required this.description,
    required this.objective,
    required this.iconPath,
    required this.isCompleted,
  });



  static List<WorkoutBadge> getBadges() {return [
    WorkoutBadge(
      name: "Duck Bodybuilder",
      description: "Prove your strength on the bench press!",
      objective: "Bench press a total of 300 kg across all sessions.",
      iconPath: "assets/badges/Badge1.png",
      isCompleted: () => false,
    ),
    WorkoutBadge(
      name: "Flying Duck",
      description: "Take your cardio to the next level.",
      objective: "Run 5 km on the treadmill in under 25 minutes.",
      iconPath: "assets/badges/Badge2.png",
      isCompleted: () => true,
    ),
    WorkoutBadge(
      name: "Weightlifting Duck",
      description: "Show your strength in deadlifts.",
      objective: "Achieve a 1-rep max (1RM) of 150 kg in deadlifts.",
      iconPath: "assets/badges/Badge3.png",
      isCompleted: () => true,
    ),
    WorkoutBadge(
      name: "Climbing Duck",
      description: "Conquer the stair climber.",
      objective: "Climb 1,000 steps on the stair climber in one session.",
      iconPath: "assets/badges/Badge4.png",
      isCompleted: () => true,
    ),
    WorkoutBadge(
      name: "Meditative Duck",
      description: "Focus on recovery and flexibility.",
      objective:
          "Complete 10 minutes of stretching after every workout for a week.",
      iconPath: "assets/badges/Badge5.png",
      isCompleted: () => true,
    ),
    WorkoutBadge(
      name: "Marathon Duck",
      description: "Test your endurance with kettlebells.",
      objective: "Complete 100 kettlebell swings in one workout.",
      iconPath: "assets/badges/Badge6.png",
      isCompleted: () => true,
    ),
  ];}
}
