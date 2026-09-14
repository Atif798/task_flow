import 'package:hive/hive.dart';
import '../models/todo.dart';

class TodoRepository {
  static const String boxName = 'todos';

  Future<void> init() async {
    await Hive.openBox<Todo>(boxName);
  }

  Box<Todo> get _box => Hive.box<Todo>(boxName);

  List<Todo> getTodos() {
    return _box.values.toList();
  }

  Future<void> addTodo(Todo todo) async {
    await _box.put(todo.id, todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await _box.put(todo.id, todo);
  }

  Future<void> deleteTodo(String id) async {
    await _box.delete(id);
  }
}