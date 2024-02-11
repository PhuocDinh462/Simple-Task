import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/utils/colors.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/providers/task_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/widgets/dialogs/edit_task_dialog.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({Key? key, required this.task}) : super(key: key);
  final Task task;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 17,
                        color: TextColors.color_900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Due: ${DateFormat('MM/dd/yyyy HH:mm').format(task.due)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: task.due.isAfter(DateTime.now())
                            ? TextColors.color_400
                            : Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        // Tool menu
        ToolMenu(task: task),
      ],
    );
  }
}

class ToolMenu extends StatelessWidget {
  const ToolMenu({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    final TaskListProvider taskListProvider =
        Provider.of<TaskListProvider>(context);

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
            onPressed: () {
              if (index == 0) {
                // Edit task
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EditTaskDialog(selectedTask: task);
                  },
                );
              } else {
                taskListProvider.deleteTask(task);
              }
            },
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
