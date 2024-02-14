import 'package:flutter/material.dart';
import 'package:to_do_list/screens/done.dart';
import 'package:to_do_list/screens/settings.dart';
import 'package:to_do_list/screens/to_do.dart';
import 'package:to_do_list/utils/colors.dart';

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
        onDestinationSelected: (int index) =>
            setState(() => currentScreenIndex = index),
        indicatorColor: MainColors.primary_300,
        selectedIndex: currentScreenIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: Icon(
              Icons.check_box_outline_blank_rounded,
              color: currentScreenIndex == 0
                  ? TextColors.color_50
                  : TextColors.color_900,
            ),
            label: 'ToDo',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.check_box_outlined,
              color: currentScreenIndex == 1
                  ? TextColors.color_50
                  : TextColors.color_900,
            ),
            label: 'Done',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.settings,
              color: currentScreenIndex == 2
                  ? TextColors.color_50
                  : TextColors.color_900,
            ),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        const ToDo(),
        const Done(),
        Settings()
      ][currentScreenIndex],
    );
  }
}
