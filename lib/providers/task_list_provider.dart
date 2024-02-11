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

  void deleteAllDoneTasks() {
    taskList.removeWhere((element) => element.status);
    notifyListeners();
  }

  void updateTask({
    String? id,
    String? content,
    DateTime? due,
    bool? status,
  }) {
    if (id == null) return;

    int index = taskList.indexWhere((task) => task.id == id);
    if (index == -1) return;

    Task taskToUpdate = taskList[index];

    if (content != null) {
      taskToUpdate.content = content;
    }

    if (due != null) {
      taskToUpdate.due = due;
    }

    if (status != null) {
      taskToUpdate.status = status;
    }

    notifyListeners();
  }
}
