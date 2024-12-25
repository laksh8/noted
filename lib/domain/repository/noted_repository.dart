// define what app can do

import 'package:noted/domain/models/todo.dart';

abstract class NotedRepository {
  Future<void> createTodos(Todo newTodo);

  Future<List<Todo>> readTodos();

  Future<void> updateTodos(Todo todo);

  Future<void> deleteTodos(Todo todo);
}
