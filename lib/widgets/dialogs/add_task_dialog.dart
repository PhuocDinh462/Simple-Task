import 'package:flutter/material.dart';
import 'package:to_do_list/utils/colors.dart';

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
    return AlertDialog(
      title: const Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _textController,
            decoration: const InputDecoration(labelText: 'Task content'),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Due:'),
              TextButton(
                onPressed: () => _selectDateAndTime(context),
                child: Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year} '
                  '${_selectedTime.hour < 10 ? 0 : ""}${_selectedTime.hour}:'
                  '${_selectedTime.minute < 10 ? 0 : ""}${_selectedTime.minute}',
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
          onPressed: () {
            // Handle the submit action here
            // String taskName = _textController.text;
            // DateTime dueDate = _selectedDate;

            // Do something with taskName and dueDate
            // print('Task Name: $taskName');
            // print('Due Date: $dueDate');

            Navigator.of(context).pop(); // Close the dialog
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
