import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';

class TaskListProvider with ChangeNotifier {
  List<Task> taskList = [];

  List<Task> get getTaskList => taskList;

  void addTask(Task task) {
    taskList.add(task);
    notifyListeners();
  }

  void deleteTask(Task task) {
    taskList.remove(task);
    notifyListeners();
  }

  void updateTask(String id,
      [String? newContent, DateTime? newDue, bool? newStatus]) {
    int index = taskList.indexWhere((task) => task.id == id);
    taskList[index].content = newContent ?? taskList[index].content;
    taskList[index].due = newDue ?? taskList[index].due;
    taskList[index].status = newStatus ?? taskList[index].status;
    notifyListeners();
  }
}
