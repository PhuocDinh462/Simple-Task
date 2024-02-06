import 'package:flutter/material.dart';
import 'package:to_do_list/screens/done.dart';
import 'package:to_do_list/screens/settings.dart';
import 'package:to_do_list/screens/to_do.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentScreenIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentScreenIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.check_box_outline_blank_rounded),
            label: 'ToDo',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_box_outlined),
            label: 'Done',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        const ToDo(),
        const Done(),
        const Settings()
      ][currentScreenIndex],
    );
  }
}
