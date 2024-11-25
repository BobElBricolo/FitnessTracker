import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:flutter/material.dart';

class FilterDialog extends StatelessWidget {
  final Map<String, List<String>> muscleGroups;
  final String? selectedMuscleGroup;
  final String? selectedEquipment;
  final VoidCallback onReset;
  final Function(String?, String?) onApply;

  const FilterDialog({
    super.key,
    required this.muscleGroups,
    required this.selectedMuscleGroup,
    required this.selectedEquipment,
    required this.onReset,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    String? tempSelectedMuscleGroup = selectedMuscleGroup;
    String? tempSelectedEquipment = selectedEquipment;

    return AlertDialog(
      backgroundColor: ColorsHelper.cardColor,
      title: const Text('Filter Exercises'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: tempSelectedMuscleGroup,
            items: [
              const DropdownMenuItem(value: null, child: Text('All Muscle Groups')),
              ...muscleGroups.keys.map((group) {
                return DropdownMenuItem(value: group, child: Text(group));
              }),
            ],
            onChanged: (value) {
              tempSelectedMuscleGroup = value;
            },
            decoration: const InputDecoration(labelText: 'Muscle Group'),
          ),
          DropdownButtonFormField<String>(
            value: tempSelectedEquipment,
            items: const [
              DropdownMenuItem(value: null, child: Text('All Equipment')),
              DropdownMenuItem(value: 'Barbell', child: Text('Barbell')),
              DropdownMenuItem(value: 'Dumbbell', child: Text('Dumbbell')),
              DropdownMenuItem(value: 'Body Only', child: Text('Body Only')),
              DropdownMenuItem(value: 'Cable', child: Text('Cable')),
              DropdownMenuItem(value: 'Machine', child: Text('Machine')),
            ],
            onChanged: (value) {
              tempSelectedEquipment = value;
            },
            decoration: const InputDecoration(labelText: 'Equipment'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            onReset();
            Navigator.pop(context); 
          },
          child: const Text('Reset Filters', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel', style: TextStyle(color: ColorsHelper.cardTextColor)),
        ),
        TextButton(
          onPressed: () {
            onApply(tempSelectedMuscleGroup, tempSelectedEquipment);
            Navigator.pop(context);
          },
          child: const Text('Apply', style: TextStyle(color: ColorsHelper.cardTextColor),
        ),
    )],
    );
  }
}
