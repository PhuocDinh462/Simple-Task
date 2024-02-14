import 'package:flutter/material.dart';
import 'package:to_do_list/providers/task_list_provider.dart';
import 'package:to_do_list/services/local_notification.dart';
import 'package:to_do_list/utils/colors.dart';
import 'package:to_do_list/widgets/dialogs/yes_no_dialog.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final LocalNotificationServices services = LocalNotificationServices();

  @override
  Widget build(BuildContext context) {
    services.init();
    final TaskListProvider taskListProvider =
        Provider.of<TaskListProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            color: MainColors.primary_300,
            height: MediaQuery.of(context).viewPadding.top + 60,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  10, MediaQuery.of(context).viewPadding.top, 10, 5),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 26,
                      color: TextColors.color_50,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: [
                  const Text(
                    'Delete data',
                    style: TextStyle(
                      color: MainColors.primary_300,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return YesNoDialog(
                            title: 'Confirmation',
                            content: 'Delete all data?',
                            onYesPressed: () {
                              taskListProvider.deleteAll();
                              services.cancelAllSchNotification();
                            });
                      },
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.delete_forever_outlined,
                          size: 28,
                          color: Color.fromARGB(255, 211, 26, 13),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Delete Data',
                          style: TextStyle(
                            fontSize: 20,
                            color: TextColors.color_700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
