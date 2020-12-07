import 'package:Todo/data_storing_retrieveing_fun.dart';
import 'package:Todo/model/todo_model.dart';
import 'package:flutter/widgets.dart';

class TodoList with ChangeNotifier {
  // List<TodoItem> todoData = [
  //   TodoItem(
  //       isDone: false, title: "first todo", description: "Kam kr", urgency: 0),
  //   TodoItem(
  //       isDone: true, title: "second todo", description: "Kam kr", urgency: 1),
  //   TodoItem(
  //       isDone: false, title: "third todo", description: "Kam kr", urgency: 2),
  // ];
  List<TodoItem> todoData = [];

  void initializeData(List<TodoItem> todos) {
    this.todoData = todos;
  }

  void deleteTodo(int index) {
    todoData.removeAt(index);
    SharedPrefFun().storeList(todoData);

    notifyListeners();
  }

  void addNewTodo(TodoItem newTodoItem) {
    todoData.insert(0, newTodoItem);
    SharedPrefFun().storeList(todoData);
    notifyListeners();
  }

  void editTodo(TodoItem todo, int index) {
    todoData[index] = todo;
    SharedPrefFun().storeList(todoData);
    notifyListeners();
  }

  void toggleTodoDone(int index) {
    todoData[index].isDone = !todoData[index].isDone;
    SharedPrefFun().storeList(todoData);

    notifyListeners();
  }
}
