import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/utils/colors.dart';
import 'package:to_do_list/widgets/custom_search_bar.dart';
import 'package:to_do_list/widgets/dialogs/add_task_dialog.dart';
import 'package:to_do_list/widgets/filter_menu.dart';
import 'package:to_do_list/widgets/task_item.dart';
import 'package:to_do_list/providers/task_list_provider.dart';
import 'package:provider/provider.dart';

class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ToDoState();
}

class ToDoState extends State<ToDo> {
  bool searchOpen = false;
  String searchText = "";
  FilterItem selectedMenu = FilterItem.all;

  @override
  Widget build(BuildContext context) {
    final TaskListProvider taskListProvider =
        Provider.of<TaskListProvider>(context);

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
            height: MediaQuery.of(context).viewPadding.top + 60,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  10, MediaQuery.of(context).viewPadding.top, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: searchOpen
                        ? CustomSearchBar(
                            textColor: TextColors.color_50,
                            hintText: 'Search',
                            onChanged: (value) =>
                                setState(() => searchText = value))
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
                          onPressed: () => setState(() {
                            if (searchOpen) {
                              searchText = "";
                            }
                            searchOpen = !searchOpen;
                          }),
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
                ...taskListProvider.getTaskList
                    // Filter
                    .where((element) {
                      if (selectedMenu == FilterItem.all) {
                        return true;
                      } else if (selectedMenu == FilterItem.today) {
                        final now = DateTime.now();
                        return element.due.year == now.year &&
                            element.due.month == now.month &&
                            element.due.day == now.day;
                      } else {
                        return element.due.isAfter(DateTime.now());
                      }
                    })
                    // Search
                    .where((element) =>
                        element.content
                            .toLowerCase()
                            .contains(searchText.toLowerCase()) ||
                        DateFormat('MM/dd/yyyy HH:mm')
                            .format(element.due)
                            .contains(searchText))
                    // Status
                    .where((element) => !element.status)
                    .map((task) => Column(
                          children: [
                            TaskItem(task: task),
                            const SizedBox(height: 15),
                            const Divider(
                              height: .5,
                              thickness: .5,
                              indent: 15,
                              endIndent: 15,
                              color: TextColors.color_600,
                            ),
                            const SizedBox(height: 15),
                          ],
                        )),
                const SizedBox(height: 75),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
