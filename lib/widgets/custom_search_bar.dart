import 'package:flutter/material.dart';
import 'package:to_do_list/models/debouncer.dart';

class CustomSearchBar extends StatelessWidget {
  final Color textColor;
  final String hintText;
  final ValueChanged<String> onChanged;
  final _debouncer = Debouncer(milliseconds: 500);

  CustomSearchBar(
      {super.key,
      required this.textColor,
      required this.hintText,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        onChanged: (value) => _debouncer.run(() => onChanged(value)),
        autofocus: true,
        cursorColor: textColor,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: textColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: textColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: textColor),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 20,
              color: textColor,
            )),
        style: TextStyle(
          fontSize: 20,
          color: textColor,
          decorationColor: textColor,
        ),
      ),
    );
  }
}
