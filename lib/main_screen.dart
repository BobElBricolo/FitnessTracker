import 'package:fitness_tracker/pages/progress/grid/gym_days_page.dart';
import 'package:flutter/material.dart';
import 'package:fitness_tracker/pages/details/details.dart';
import 'package:fitness_tracker/pages/exercises/exercises_page.dart';
import 'package:fitness_tracker/pages/home/home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Liste des pages
  final List<Widget> _pages = [
    const HomePage(),
    const ExerciseListPage(),
    const HomePage(),
    const GymDaysPage(),
    const DetailsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: const Color(0xff1ebdf8),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Exercises',
          ),
          BottomNavigationBarItem(
            icon: Transform.translate(
              offset: const Offset(0, -10),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [Color(0xff92e2ff), Color(0xff1ebdf8)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 3.0),
                      blurRadius: 3,
                    )
                  ],
                ),
                child: const Icon(Icons.home, color: Colors.white),
              ),
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: 'Progress',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
