import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';

class TaskListProvider with ChangeNotifier {
  List<Task> taskList = [];

  List<Task> get getTaskList => taskList;

  void addTask(Task task) {
    taskList.add(task);
    notifyListeners();
  }
}
