import 'package:isar/isar.dart';
import 'package:noted/domain/models/todo.dart';

// to generate isar todo object run: dart run build_runner build
part 'isar_todo.g.dart';

@collection
class IsarTodo {
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  // convert isarTodo to todo object
  Todo toDomain() {
    return Todo(
      id: id,
      text: text,
      isCompleted: isCompleted,
    );
  }

  // creates a new isar object from a todo object

  static IsarTodo fromDomain(Todo todo) {
    return IsarTodo()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
  }
}
