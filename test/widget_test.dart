import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted/domain/models/todo.dart';
import 'package:noted/domain/repository/todo_repository.dart';
import 'package:noted/main.dart';

class MockTodoRepository implements TodoRepository {
  final List<Todo> _todos = [];

  Future<List<Todo>> getTodos() async => _todos;

  Future<void> createTodo(String text) async {
    _todos.add(Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
      isCompleted: false,
    ));
  }

  Future<void> deleteTodo(Todo todo) async {
    _todos.remove(todo);
  }

  Future<void> toggleTodoCompletion(Todo todo) async {
    final index = _todos.indexOf(todo);
    if (index != -1) {
      _todos[index] = Todo(
        id: todo.id,
        text: todo.text,
        isCompleted: !todo.isCompleted,
      );
    }
  }

  @override
  Future<void> createTodos(Todo newTodo) {
    // TODO: implement createTodos
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTodos(Todo todo) {
    // TODO: implement deleteTodos
    throw UnimplementedError();
  }

  @override
  Future<List<Todo>> readTodos() {
    // TODO: implement readTodos
    throw UnimplementedError();
  }

  @override
  Future<void> updateTodos(Todo todo) {
    // TODO: implement updateTodos
    throw UnimplementedError();
  }
}

void main() {
  testWidgets('Add, toggle, and delete a to-do item',
      (WidgetTester tester) async {
    final mockRepository = MockTodoRepository();

    // Build the app with the mock repository.
    await tester.pumpWidget(MyApp(todoRepository: mockRepository));

    // Verify the initial state (no to-do items).
    expect(find.byType(ListTile), findsNothing);

    // Add a to-do item.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Enter text in the dialog and confirm.
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    await tester.enterText(textField, 'Test To-Do');
    await tester.tap(find.text('Add +'));
    await tester.pumpAndSettle();

    // Verify the to-do item is displayed.
    expect(find.text('Test To-Do'), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);

    // Toggle the completion status.
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    // Verify the item is toggled (UI should update accordingly if designed to).
    expect(
      (tester.widget(find.byType(Checkbox)) as Checkbox).value,
      isTrue,
    );

    // Delete the to-do item.
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    // Verify the to-do item is deleted.
    expect(find.text('Test To-Do'), findsNothing);
    expect(find.byType(ListTile), findsNothing);
  });
}
