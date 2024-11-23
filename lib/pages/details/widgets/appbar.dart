import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget{

  final AppBar appBar;
  const MainAppBar({super.key, required this.appBar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          'Activity Details',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(5),
              shape: const CircleBorder(), 
              iconColor: const Color(0xfffa7a3b),
              backgroundColor: const Color(0xffffe6da),
              maximumSize: const Size(30, 30),
              minimumSize: const Size(30, 30),
            ),
            child: const Icon(
              Icons.notifications,
              size: 16,
            ),
          )
        ],
      );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}