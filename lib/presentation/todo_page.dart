import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted/domain/repository/todo_repository.dart';
import 'package:noted/presentation/todo_cubit.dart';
import 'package:noted/presentation/todo_view.dart';

class TodoPage extends StatelessWidget {
  final TodoRepository todoRepository;
  const TodoPage({super.key, required this.todoRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(todoRepository),
      child: const TodoView(),
    );
  }
}
