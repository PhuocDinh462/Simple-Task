import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Task {
  String id;
  String content;
  DateTime due;
  bool status;

  Task({
    required this.content,
    required this.due,
  })  : id = uuid.v1(),
        status = false;

  Task.withAllFields({
    required this.content,
    required this.due,
    required this.status,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'due': due.toIso8601String(),
      'status': status,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task.withAllFields(
      id: map['id'],
      content: map['content'],
      due: DateTime.parse(map['due']),
      status: map['status'],
    );
  }
}
