import 'package:Todo/UI/todo_add_edit_screen.dart';
import 'package:Todo/model/todo_model.dart';
import 'package:Todo/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TodoTaskDesc extends StatelessWidget {
  TodoItem todo;
  int index;
  TodoTaskDesc({this.index});

  List<Color> urgencyColor = [Colors.green, Colors.yellow, Colors.red];

  _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      iconTheme: IconThemeData(color: Colors.indigo),
      backgroundColor: Colors.white,
      title: Text("Todo Task",
          style: TextStyle(
            color: Colors.indigo,
          )),
      actions: [
        IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ToDoTaskAddEditScreen(
                        currentTodoItem: todo,
                        index: index,
                      )));
            })
      ],
    );
  }

  Widget _buildGeneralTitleAndSection(String title, String content) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            content,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.8)),
          )
        ],
      ),
    );
  }

  Widget urgency(int idx) {
    return Container(
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: urgencyColor[idx]),
      child: Container(
        height: 30,
        width: 30,
      ),
    );
  }

  _buildUrgencySection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Urgency",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          urgency(todo.urgency)
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGeneralTitleAndSection("Title", todo.title),
            _buildGeneralTitleAndSection("Description", todo.description),
            _buildUrgencySection()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    todo = Provider.of<TodoList>(context).todoData[index];
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }
}
