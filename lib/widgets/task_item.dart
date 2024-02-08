import 'package:flutter/material.dart';
import 'package:to_do_list/utils/colors.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Checkbox, content and due to
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return MainColors.primary_300;
                    }
                    return null;
                  },
                ),
                value: false,
                onChanged: (bool? value) {},
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 100,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'lorem ipsum dolor sit amet, con lorem ipsum dolor sit amet, con lorem ipsum dolor sit amet, con',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 17,
                        color: TextColors.color_900,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Due to: 03/01/2024 23:59',
                      style: TextStyle(
                        fontSize: 14,
                        color: TextColors.color_400,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        // Tool menu
        const ToolMenu(),
      ],
    );
  }
}

class ToolMenu extends StatelessWidget {
  const ToolMenu({
    Key? key,
  }) : super(key: key);

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
          icon: const Icon(Icons.more_vert),
          iconSize: 32,
          color: TextColors.color_500,
          tooltip: 'Filter',
        );
      },
      menuChildren: List<MenuItemButton>.generate(
        2,
        (int index) {
          return MenuItemButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  index == 0 ? Icons.edit : Icons.delete,
                  color: TextColors.color_600,
                ),
                const SizedBox(width: 10),
                Text(
                  index == 0 ? 'Edit' : 'Delete',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
