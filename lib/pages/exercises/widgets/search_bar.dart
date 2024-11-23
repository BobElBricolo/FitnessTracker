import 'package:flutter/material.dart';

class ExerciseSearchBar extends StatelessWidget {
  final ValueChanged<String> onSearchChanged; // Callback pour la recherche
  final VoidCallback onFilterTapped;         // Callback pour le clic sur le bouton de filtre
  final bool hasActiveFilters;               // Indicateur pour savoir si un filtre est actif

  const ExerciseSearchBar({
    super.key,
    required this.onSearchChanged,
    required this.onFilterTapped,
    required this.hasActiveFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search for an exercise...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onFilterTapped,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: Icon(
                hasActiveFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
                color: hasActiveFilters ? Colors.blue : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
