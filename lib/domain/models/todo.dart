// model for a 'TODO' component

// methods --> toggleCompletion()
// props --> id, text, isCompleted

class Todo {
  Todo({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });

  final int id;
  final String text;
  final bool isCompleted;

  Todo toggleCompletion() {
    return Todo(
      id: id,
      text: text,
      isCompleted: !isCompleted,
    );
  }
}
