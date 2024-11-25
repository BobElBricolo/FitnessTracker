import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/models/exercise.dart';
import 'package:fitness_tracker/pages/exercise_details/exercise_details.dart';
import 'package:fitness_tracker/pages/exercises/widgets/exercises_card.dart';
import 'package:fitness_tracker/pages/exercises/widgets/filter_dialog.dart';
import 'package:fitness_tracker/pages/exercises/widgets/search_bar.dart';
import 'package:fitness_tracker/requests/fetch_exercises.dart';
import 'package:flutter/material.dart';

class ExerciseListPage extends StatefulWidget {
  const ExerciseListPage({super.key});

  @override
  ExerciseListPageState createState() => ExerciseListPageState();
}

class ExerciseListPageState extends State<ExerciseListPage> {
  late Future<List<Exercise>> _exercisesFuture;
  List<Exercise> _allExercises = [];
  List<Exercise> _filteredExercises = [];
  String _searchQuery = '';
  String? _selectedMuscleGroup;
  String? _selectedEquipment;

  @override
  void initState() {
    super.initState();
    _exercisesFuture = ApiService.fetchAllExercises();
    _exercisesFuture.then((exercises) {
      setState(() {
        _allExercises = exercises;
        _filteredExercises = exercises;
      });
    });
  }

  Map<String, List<String>> getMuscleGroups() {
    return {
      'Back': [
        'lats',
        'middle back',
        'traps',
        'neck',
        'back',
        'upper back',
        'lower back'
      ],
      'Legs': [
        'quadriceps',
        'hamstrings',
        'glutes',
        'adductors',
        'abductors',
        'calves'
      ],
      'Abs': ['abdominals'],
      'Arms': ['triceps', 'biceps', 'forearms'],
      'Chest': ['chest', 'shoulders'],
    };
  }

  bool _hasActiveFilters() {
    return _selectedMuscleGroup != null || _selectedEquipment != null;
  }

  void _filterExercises(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _applyFilters();
    });
  }

  void _applyFilters() {
    setState(() {
      _filteredExercises = _allExercises.where((exercise) {
        final matchesQuery = exercise.name
                .toLowerCase()
                .contains(_searchQuery) ||
            exercise.primaryMuscles
                .any((muscle) => muscle.toLowerCase().contains(_searchQuery));

        final matchesMuscleGroup = _selectedMuscleGroup == null ||
            getMuscleGroups()[_selectedMuscleGroup]!
                .any((muscle) => exercise.primaryMuscles.contains(muscle));

        final matchesEquipment = _selectedEquipment == null ||
            exercise.equipment.toLowerCase() ==
                _selectedEquipment!.toLowerCase();

        return matchesQuery && matchesMuscleGroup && matchesEquipment;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsHelper.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsHelper.backgroundColor,
        title: const Text("Exercises", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: ColorsHelper.textColor),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ExerciseSearchBar(
            onSearchChanged: _filterExercises,
            onFilterTapped: () => _showFilterDialog(context),
            hasActiveFilters: _hasActiveFilters(),
          ),
          Expanded(
            child: FutureBuilder<List<Exercise>>(
              future: _exercisesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No exercises available'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  itemCount: _filteredExercises.length,
                  itemBuilder: (context, index) {
                    final exercise = _filteredExercises[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ExerciseDetailPage(exercise: exercise),
                          ),
                        );
                      },
                      child: ExerciseCardWithDetails(exercise: exercise),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return FilterDialog(
          muscleGroups: getMuscleGroups(),
          selectedMuscleGroup: _selectedMuscleGroup,
          selectedEquipment: _selectedEquipment,
          onReset: () {
            setState(() {
              _selectedMuscleGroup = null;
              _selectedEquipment = null;
              _searchQuery = '';
              _applyFilters();
            });
          },
          onApply: (String? muscleGroup, String? equipment) {
            setState(() {
              _selectedMuscleGroup = muscleGroup;
              _selectedEquipment = equipment;
              _applyFilters();
            });
          },
        );
      },
    );
  }
}
