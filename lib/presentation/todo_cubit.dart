// cubit: simplified business logic component
// here, each cubit is a list of todos

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted/domain/models/todo.dart';
import 'package:noted/domain/repository/todo_repository.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepository todoRepository;

  TodoCubit(this.todoRepository)
      : super(
          [], // calls the constructor of Cubit and sets initial state to []
        ) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final todoList = await todoRepository.readTodos();

    // emit fetched todos
    emit(todoList);
  }

  Future<void> createTodo(String text) async {
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
    );

    await todoRepository.createTodos(newTodo);

    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await todoRepository.deleteTodos(todo);

    loadTodos();
  }

  Future<void> toggle(Todo todo) async {
    final updatedTodo = todo.toggleCompletion();

    await todoRepository.updateTodos(updatedTodo);

    loadTodos();
  }
}
