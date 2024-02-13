import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/services/local_notification.dart';
import 'package:to_do_list/utils/colors.dart';
import 'package:to_do_list/providers/task_list_provider.dart';
import 'package:provider/provider.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<StatefulWidget> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  late TextEditingController _textController;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  late final LocalNotificationServices services;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();

    services = LocalNotificationServices();
    services.init();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _selectDateAndTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate && mounted) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _selectedTime = pickedTime;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final TaskListProvider taskListProvider =
        Provider.of<TaskListProvider>(context);

    return AlertDialog(
      title: const Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _textController,
            decoration: const InputDecoration(labelText: 'Task content'),
            autofocus: true,
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Due:'),
              TextButton(
                onPressed: () => _selectDateAndTime(context),
                child: Text(
                  DateFormat('MM/dd/yyyy HH:mm').format(_selectedDate),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: TextColors.color_500,
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            // Handle the submit action
            String taskContent = _textController.text;
            DateTime dueDate = _selectedDate;
            taskListProvider.addTask(Task(content: taskContent, due: dueDate));

            Navigator.of(context).pop(); // Close the dialog

            await services.showSchNotification(
                id: 0,
                title: "Your task will be due soon!",
                body: "Due: ${DateFormat('MM/dd/yyyy HH:mm').format(dueDate)}",
                sec: 5);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: MainColors.primary_300,
            foregroundColor: TextColors.color_50,
          ),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
