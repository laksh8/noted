import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted/domain/models/todo.dart';
import 'package:noted/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    return Scaffold(
      body: BlocBuilder<TodoCubit, List<Todo>>(builder: (context, items) {
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final todo = items[index];
            return ListTile(
              leading: Checkbox(
                value: todo.isCompleted,
                onChanged: (value) => todoCubit.toggle(todo),
              ),
              title: Text(
                todo.text,
                style: todo.isCompleted
                    ? const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey)
                    : const TextStyle(),
              ),
              trailing: IconButton(
                onPressed: () => todoCubit.deleteTodo(todo),
                icon: const Icon(Icons.delete),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoBox(context, todoCubit);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoBox(BuildContext context, TodoCubit todoCubit) {
    final TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              todoCubit.createTodo(textController.text);
            },
            child: const Text("Add +"),
          ),
        ],
      ),
    );
  }
}
