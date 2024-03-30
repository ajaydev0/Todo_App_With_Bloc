import 'package:bloc/bloc.dart';
part 'todo_state.dart';

class Todo {
  static List<String> data = [
    "Ajay Kumar Nath",
    "Snigdha Paul",
    "Prionty Barua",
    "Lima Das",
    "Nisita Nath",
  ];
}

class TodoCubit extends Cubit<TodoInitial> {
  TodoCubit() : super(TodoInitial(todos: Todo.data));

  addTodo(String text) {
    final todoList = state.todos;
    todoList.add(text);
    emit(TodoInitial(todos: todoList));
  }

  deleteTodo(int index) {
    final todoList = state.todos;
    todoList.removeAt(index);
    emit(TodoInitial(todos: todoList));
  }

  closeAll() {
    final todoList = state.todos;
    todoList.clear();
    emit(TodoInitial(todos: todoList));
  }
}
