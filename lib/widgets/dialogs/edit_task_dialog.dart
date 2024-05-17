import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/services/notification.service.dart';
import 'package:to_do_list/utils/colors.dart';
import 'package:to_do_list/providers/task_list_provider.dart';
import 'package:provider/provider.dart';

class EditTaskDialog extends StatefulWidget {
  const EditTaskDialog({super.key, required this.selectedTask});
  final Task selectedTask;

  @override
  State<StatefulWidget> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController _textController;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late final Task _selectedTask = widget.selectedTask;

  late final NotificationService services;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: _selectedTask.content);
    _selectedDate = _selectedTask.due;
    _selectedTime = TimeOfDay.fromDateTime(_selectedTask.due);

    services = NotificationService();
    services.initNotification();
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
      title: const Text('Edit Task'),
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
                child:
                    Text(DateFormat('MM/dd/yyyy HH:mm').format(_selectedDate)),
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
            taskListProvider.updateTask(
                id: _selectedTask.id, content: taskContent, due: dueDate);

            Navigator.of(context).pop(); // Close the dialog

            // Notification
            await services.cancelSchNotificationById(
                id: _selectedTask.id.hashCode);
            await services.showSchNotification(
              id: _selectedTask.id.hashCode,
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
          child: const Text('Edit'),
        ),
      ],
    );
  }
}
