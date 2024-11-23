class Exercise {
  final String category;
  final String equipment;
  final String force;
  final String id;
  final List<String> images;
  final List<String> instructions;
  final String level;
  final String? mechanic; 
  final String name;
  final List<String> primaryMuscles;
  final List<String> secondaryMuscles;

  Exercise({
    required this.category,
    required this.equipment,
    required this.force,
    required this.id,
    required this.images,
    required this.instructions,
    required this.level,
    this.mechanic,
    required this.name,
    required this.primaryMuscles,
    required this.secondaryMuscles,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      category: json['category'],
      equipment: json['equipment'],
      force: json['force'],
      id: json['id'],
      images: List<String>.from(json['images'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      level: json['level'],
      mechanic: json['mechanic'],
      name: json['name'],
      primaryMuscles: List<String>.from(json['primaryMuscles'] ?? []),
      secondaryMuscles: List<String>.from(json['secondaryMuscles'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'equipment': equipment,
      'force': force,
      'id': id,
      'images': images,
      'instructions': instructions,
      'level': level,
      'mechanic': mechanic,
      'name': name,
      'primaryMuscles': primaryMuscles,
      'secondaryMuscles': secondaryMuscles,
    };
  }
}
