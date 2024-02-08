import 'package:flutter/material.dart';
import 'package:to_do_list/utils/colors.dart';

enum FilterItem { all, today, upComing }

class FilterMenu extends StatelessWidget {
  final FilterItem selectedMenu;
  final ValueChanged<FilterItem> onItemSelected;
  const FilterMenu(
      {Key? key, required this.selectedMenu, required this.onItemSelected})
      : super(key: key);

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
      // alignmentOffset: const Offset(-80, 0),
      menuChildren: List<MenuItemButton>.generate(
        3,
        (int index) {
          final FilterItem item = FilterItem.values[index];
          return MenuItemButton(
            onPressed: () => onItemSelected(item),
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
