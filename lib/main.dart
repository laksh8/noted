import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:noted/data/models/isar_todo.dart';
import 'package:noted/data/repository/isar_todo_repository.dart';
import 'package:noted/domain/repository/todo_repository.dart';
import 'package:noted/presentation/todo_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();

  final isarDb = await Isar.open(
    [IsarTodoSchema],
    directory: dir.path,
  ); // schema generated by isar in .g.part

  final IsarTodoRepository isarTodoRepository = IsarTodoRepository(isarDb);
  runApp(MyApp(
    todoRepository: isarTodoRepository,
  ));
}

class MyApp extends StatelessWidget {
  final TodoRepository todoRepository;
  const MyApp({super.key, required this.todoRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(
        todoRepository: todoRepository,
      ),
    );
  }
}
