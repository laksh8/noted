// implementation of todo repo in isar database

import 'package:isar/isar.dart';
import 'package:noted/data/models/isar_todo.dart';
import 'package:noted/domain/models/todo.dart';
import 'package:noted/domain/repository/todo_repository.dart';

class IsarTodoRepository implements TodoRepository {
  final Isar db;
  IsarTodoRepository(this.db);

  // create todos

  @override
  Future<void> createTodos(Todo newTodo) {
    //create new isartodo from todo (in domain layer)
    final IsarTodo newIsarTodo = IsarTodo.fromDomain(newTodo);

    //write transaction
    return db.writeTxn(() => db.isarTodos.put(newIsarTodo));
  }

  //read todos

  @override
  Future<List<Todo>> readTodos() async {
    // fetch from database
    final List<IsarTodo> isarTodos = await db.isarTodos.where().findAll();

    // return to domain layer
    return isarTodos.map((isarTodo) => isarTodo.toDomain()).toList();
  }

  //update todos

  @override
  Future<void> updateTodos(Todo todo) {
    //create new isartodo from todo (in domain layer)
    final IsarTodo isarTodo = IsarTodo.fromDomain(todo);

    //write transaction
    return db.writeTxn(() => db.isarTodos.put(isarTodo));
  }

  // delete todos

  @override
  Future<void> deleteTodos(Todo todo) async {
    //write transaction
    await db.writeTxn(() => db.isarTodos.delete(todo.id));
  }
}
