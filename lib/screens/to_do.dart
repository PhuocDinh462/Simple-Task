import 'package:flutter/material.dart';
import 'package:to_do_list/utils/colors.dart';
import 'package:to_do_list/widgets/custom_search_bar.dart';

class ToDo extends StatefulWidget {
  final bool searchOpen = false;

  const ToDo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ToDoState();
  }
}

class ToDoState extends State<ToDo> {
  late bool searchOpen;

  @override
  void initState() {
    super.initState();
    searchOpen = widget.searchOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          color: MainColors.primary_300,
          height: 60,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: searchOpen
                      ? const CustomSearchBar(
                          textColor: TextColors.color_50, hintText: 'Search')
                      : const Text(
                          'ToDo',
                          style: TextStyle(
                            fontSize: 26,
                            color: TextColors.color_50,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15.0),
                  child: IconButton(
                    onPressed: () => setState(() => searchOpen = !searchOpen),
                    icon: Icon(searchOpen ? Icons.clear_sharp : Icons.search),
                    iconSize: 32,
                    color: TextColors.color_50,
                  ),
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
}
