import 'package:flutter/material.dart';
import 'package:to_do_list/utils/colors.dart';

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          color: MainColors.primary_300,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ToDo',
                  style: TextStyle(
                    fontSize: 26,
                    color: TextColors.color_50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: handleSearch,
                  icon: const Icon(Icons.search),
                  iconSize: 32,
                  color: TextColors.color_50,
                ),
              ],
            ),
          ),
        ),

        // Body
        Container(),
      ],
    );
  }

  void handleSearch() {}
}
