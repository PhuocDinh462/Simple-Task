import 'package:flutter/material.dart';
import 'package:to_do_list/utils/colors.dart';

class YesNoDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onYesPressed;

  const YesNoDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onYesPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: TextColors.color_500,
          ),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onYesPressed();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: MainColors.primary_300,
          ),
          child: const Text('Continue'),
        ),
      ],
    );
  }
}
