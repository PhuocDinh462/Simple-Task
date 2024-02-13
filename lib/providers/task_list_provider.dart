import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/models/task.dart';

List<Map<String, dynamic>> taskListToMap(List<Task> tasks) {
  return tasks.map((task) => task.toMap()).toList();
}

Future<void> saveTasks(List<Task> tasks) async {
  final prefs = await SharedPreferences.getInstance();
  final tasksMapList = taskListToMap(tasks);
  await prefs.setString('taskList', jsonEncode(tasksMapList));
}

Future<List<Task>> loadTasks() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('taskList');

  if (jsonString != null) {
    final tasksMapList = jsonDecode(jsonString).cast<Map<String, dynamic>>();
    return tasksMapList.map<Task>((taskMap) => Task.fromMap(taskMap)).toList();
  } else {
    return [];
  }
}

class TaskListProvider with ChangeNotifier {
  List<Task> taskList = [];

  List<Task> get getTaskList => taskList;

  TaskListProvider() {
    // Load tasks
    loadTasks().then((loadedTasks) async {
      taskList = loadedTasks;
      notifyListeners();
    });
  }

  Future<void> addTask(Task task) async {
    taskList.add(task);
    notifyListeners();
    await saveTasks(taskList);
  }

  void deleteTask(Task task) {
    taskList.remove(task);
    notifyListeners();
    saveTasks(taskList);
  }

  void deleteAllDoneTasks() {
    taskList.removeWhere((element) => element.status);
    notifyListeners();
    saveTasks(taskList);
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
    saveTasks(taskList);
  }
}
