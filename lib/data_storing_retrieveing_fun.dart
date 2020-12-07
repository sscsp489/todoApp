import 'package:Todo/model/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefFun {
  void storeList(List<TodoItem> todos) async {
    final prefs = await SharedPreferences.getInstance();

    String allTodosStr = todoItemToJson(todos);
    prefs.setString("todolist", allTodosStr);
  }

  Future<List<TodoItem>> fetchList() async {
    final prefs = await SharedPreferences.getInstance();
    String allTodosStr = prefs.getString("todolist");
    if (allTodosStr == null) return [];
    List<TodoItem> list = todoItemFromJson(allTodosStr);
    return list == null ? [] : list;
  }
}
