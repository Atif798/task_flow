import 'package:hive/hive.dart';
part 'todo.g.dart';


@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String note;

  @HiveField(3)
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.note = '',
    this.isCompleted = false,
  });
}