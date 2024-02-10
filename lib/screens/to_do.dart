import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/utils/colors.dart';
import 'package:to_do_list/widgets/custom_search_bar.dart';
import 'package:to_do_list/widgets/dialogs/add_task_dialog.dart';
import 'package:to_do_list/widgets/filter_menu.dart';
import 'package:to_do_list/widgets/task_item.dart';

class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ToDoState();
}

class ToDoState extends State<ToDo> {
  bool searchOpen = false;
  FilterItem selectedMenu = FilterItem.all;

  List<Task> toDoTasks = [
    Task(content: 'Task 1', due: DateTime(2024, 3, 1)),
    Task(content: 'Task 2', due: DateTime(2024, 3, 2)),
    Task(content: 'Task 3', due: DateTime(2024, 3, 3)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddTaskDialog();
            },
          );
        },
        foregroundColor: TextColors.color_50,
        backgroundColor: MainColors.primary_300,
        child: const Icon(Icons.add),
      ),
      body: Column(
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
                          icon: Icon(
                              searchOpen ? Icons.clear_sharp : Icons.search),
                          iconSize: 32,
                          color: TextColors.color_50,
                        ),
                        FilterMenu(
                          selectedMenu: selectedMenu,
                          onItemSelected: (item) =>
                              setState(() => selectedMenu = item),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Body
          Expanded(
            child: ListView(
              children: [
                ...toDoTasks.map((task) => Column(
                      children: [
                        const SizedBox(height: 15),
                        TaskItem(task: task),
                        const SizedBox(height: 15),
                        const Divider(
                          height: .5,
                          thickness: .5,
                          indent: 15,
                          endIndent: 15,
                          color: TextColors.color_600,
                        ),
                      ],
                    )),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
