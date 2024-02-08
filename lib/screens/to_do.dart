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
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            setState(() => searchOpen = !searchOpen),
                        icon:
                            Icon(searchOpen ? Icons.clear_sharp : Icons.search),
                        iconSize: 32,
                        color: TextColors.color_50,
                      ),
                      const FilterMenu(),
                    ],
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

enum FilterItem { all, today, upComing }

class FilterMenu extends StatefulWidget {
  const FilterMenu({Key? key}) : super(key: key);

  @override
  State<FilterMenu> createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  FilterItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.filter_alt),
          iconSize: 32,
          color: TextColors.color_50,
          tooltip: 'Filter',
        );
      },
      alignmentOffset: const Offset(-80, 0),
      menuChildren: List<MenuItemButton>.generate(
        3,
        (int index) {
          final FilterItem item = FilterItem.values[index];
          return MenuItemButton(
            onPressed: () => setState(() => selectedMenu = item),
            child: Text(
              index == 0
                  ? 'All'
                  : index == 1
                      ? 'Today'
                      : 'Up coming',
              style: TextStyle(
                  fontSize: 18,
                  color: selectedMenu == item
                      ? MainColors.primary_300
                      : TextColors.color_700),
            ),
          );
        },
      ),
    );
  }
}
