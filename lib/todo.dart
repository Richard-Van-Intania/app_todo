class Todo {
  const Todo({required this.description, required this.id, this.completed = false});

  final String id;
  final String description;
  final bool completed;
}
