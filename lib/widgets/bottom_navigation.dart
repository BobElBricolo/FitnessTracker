import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 60,
        color: const Color(0xfff8f8f8),
        child: IconTheme(
          data: const IconThemeData(
            color: Color(0xffabadb4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.add_chart),
              const Icon(Icons.search),
              Transform.translate(
                  offset: const Offset(0, -13),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            colors: [Color(0xff92e2ff), Color(0xff1ebdf8)]),
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
                  )),
              const Icon(Icons.date_range),
              GestureDetector(
                  onTap: () {
                  },
                  child: const Icon(Icons.settings)),
            ],
          ),
        ));
  }
}
