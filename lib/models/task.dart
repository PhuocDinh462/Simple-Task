import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Task {
  String id;
  String content;
  DateTime due;

  Task({
    required this.content,
    required this.due,
  }) : id = uuid.v1();
}
