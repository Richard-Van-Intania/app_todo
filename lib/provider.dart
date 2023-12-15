import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'todo.dart';

part 'provider.g.dart';

const uuid = Uuid();

@riverpod
class TodoList extends _$TodoList {
  @override
  List<Todo> build() => [];

  void add(String description) {
    state = [
      ...state,
      Todo(
        id: uuid.v4(),
        description: description,
      ),
    ];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            description: todo.description,
          )
        else
          todo,
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
