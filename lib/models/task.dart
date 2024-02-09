class Task {
  String content;
  DateTime due;

  Task({
    required this.content,
    required this.due,
  });

  /// create new Task
  factory Task.create({
    required String? content,
    DateTime? due,
  }) =>
      Task(
        content: content ?? "",
        due: due ?? DateTime.now(),
      );
}
