import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Color textColor;
  final String hintText;

  const CustomSearchBar(
      {super.key, required this.textColor, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
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
        ),
      ),
    );
  }
}
