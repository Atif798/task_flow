import 'package:flutter/foundation.dart';
import '../data/todo_repository.dart';
import '../models/todo.dart';

class TodoProvider extends ChangeNotifier {
  final TodoRepository _repository;

  TodoProvider(this._repository);

  List<Todo> _todos = [];

  List<Todo> get todos => List.unmodifiable(_todos);

  int get pendingCount =>
      _todos.where((todo) => !todo.isCompleted).length;

  int get completedCount =>
      _todos.where((todo) => todo.isCompleted).length;

  Future<void> loadTodos() async {
    _todos = _repository.getTodos();
    notifyListeners();
  }

  Future<void> addTodo({
    required String title,
    String note = '',
  }) async {
    final todo = Todo(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title.trim(),
      note: note.trim(),
    );

    await _repository.addTodo(todo);

    _todos = _repository.getTodos();
    notifyListeners();
  }

  Future<void> updateTodo({
    required String id,
    required String title,
    String note = '',
  }) async {
    final index = _todos.indexWhere((todo) => todo.id == id);

    if (index == -1) return;

    final todo = _todos[index];

    todo.title = title.trim();
    todo.note = note.trim();

    await _repository.updateTodo(todo);

    _todos = _repository.getTodos();
    notifyListeners();
  }

  Future<void> toggleTodo(String id) async {
    final index = _todos.indexWhere((todo) => todo.id == id);

    if (index == -1) return;

    final todo = _todos[index];

    todo.isCompleted = !todo.isCompleted;

    await _repository.updateTodo(todo);

    _todos = _repository.getTodos();
    notifyListeners();
  }

  Future<void> deleteTodo(String id) async {
    await _repository.deleteTodo(id);

    _todos = _repository.getTodos();
    notifyListeners();
  }
}