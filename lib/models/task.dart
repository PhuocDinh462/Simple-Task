import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Task {
  final String _id;
  String content;
  DateTime due;
  bool status;

  String get id => _id;

  Task({
    required this.content,
    required this.due,
  })  : _id = uuid.v1(),
        status = false;
}
