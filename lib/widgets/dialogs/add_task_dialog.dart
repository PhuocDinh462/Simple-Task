import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/services/notification.service.dart';
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

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
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
            Task newTask = Task(content: taskContent, due: dueDate);
            taskListProvider.addTask(newTask);

            Navigator.of(context).pop(); // Close the dialog

            // Add notification
            await NotificationService().showSchNotification(
              id: newTask.id.hashCode,
              title: taskContent,
              body: "Due: ${DateFormat('MM/dd/yyyy HH:mm').format(dueDate)}",
              detail: taskContent,
              due: dueDate,
            );
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
