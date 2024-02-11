import 'package:flutter/material.dart';
import 'package:to_do_list/utils/colors.dart';
import 'package:to_do_list/widgets/custom_search_bar.dart';
import 'package:to_do_list/widgets/dialogs/add_task_dialog.dart';
import 'package:to_do_list/widgets/dialogs/yes_no_dialog.dart';
import 'package:to_do_list/widgets/filter_menu.dart';
import 'package:to_do_list/widgets/task_item.dart';
import 'package:to_do_list/providers/task_list_provider.dart';
import 'package:provider/provider.dart';

class Done extends StatefulWidget {
  const Done({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DoneState();
}

class DoneState extends State<Done> {
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
                            'Done',
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
                        IconButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return YesNoDialog(
                                title: 'Confirmation',
                                content: 'Delete all done tasks?',
                                onYesPressed: () =>
                                    taskListProvider.deleteAllDoneTasks(),
                              );
                            },
                          ),
                          icon: const Icon(Icons.delete_forever_outlined),
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
                ...taskListProvider.taskList
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
                    .where((element) => element.content
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))
                    // Status
                    .where((element) => element.status)
                    .map((task) => Column(
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

Future<bool> showAlertDialog(BuildContext context) async {
  // set up the buttons
  Widget cancelButton = TextButton(
    onPressed: () {
      Navigator.of(context).pop(false);
    },
    style: TextButton.styleFrom(
      foregroundColor: TextColors.color_500,
    ),
    child: const Text("Cancel"),
  );
  Widget continueButton = TextButton(
    onPressed: () {
      // Thực hiện function tại đây
      Navigator.of(context).pop(true);
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: MainColors.primary_300,
    ),
    child: const Text("Continue"),
  ); // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Delete all done tasks?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  ); // show the dialog
  final result = await showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
  return result ?? false;
}
