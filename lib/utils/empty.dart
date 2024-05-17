import 'package:flutter/material.dart';
import 'package:to_do_list/utils/colors.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Empty.png',
            width: MediaQuery.sizeOf(context).width / 1.5,
          ),
          const Text(
            "There's nothing here",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: TextColors.color_700,
            ),
          ),
        ],
      ),
    );
  }
}
