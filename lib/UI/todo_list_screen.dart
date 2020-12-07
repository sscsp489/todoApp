import 'package:Todo/UI/todo_add_edit_screen.dart';
import 'package:Todo/model/todo_model.dart';
import 'package:Todo/provider/todo_provider.dart';
import 'package:Todo/widgets/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        "Todo App",
        style: TextStyle(color: Colors.indigo),
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.add, color: Colors.indigo, size: 32.0),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ToDoTaskAddEditScreen(
                            currentTodoItem: null,
                            index: 0,
                          )));
            })
      ],
    );
  }

  List<Widget> allTodos(List<TodoItem> todoData) {
    List<Widget> allTodosWidgets = [];

    for (int i = 0; i < todoData.length; i++) {
      allTodosWidgets.add(TodoTile(
        todoData: todoData[i],
        index: i,
      ));
    }

    return allTodosWidgets;
  }

  Widget whenNoTodosPresent() {
    return Container(
      child: Center(
        child: Text("Please add some todo task to show here ."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TodoItem> todoData = Provider.of<TodoList>(context).todoData;
    return Scaffold(
      appBar: _buildAppBar(context),
      body: todoData.length == 0
          ? whenNoTodosPresent()
          : SingleChildScrollView(
              child: Column(
                children: allTodos(todoData),
              ),
            ),
    );
  }
}
