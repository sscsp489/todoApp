import 'package:Todo/model/todo_model.dart';
import 'package:Todo/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ToDoTaskAddEditScreen extends StatefulWidget {
  int index;
  TodoItem currentTodoItem;
  ToDoTaskAddEditScreen({this.index, this.currentTodoItem});
  @override
  _ToDoTaskAddEditScreenState createState() => _ToDoTaskAddEditScreenState();
}

class _ToDoTaskAddEditScreenState extends State<ToDoTaskAddEditScreen> {
  List<Color> urgencyColor = [Colors.green, Colors.yellow, Colors.red];
  final _formKey = GlobalKey<FormState>();
  int selectedUrgency;
  String title;
  String desc;

  AppBar _buildAppBar(bool x) {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      iconTheme: IconThemeData(color: Colors.indigo),
      backgroundColor: Colors.white,
      // centerTitle: true,
      title: Text(
        x ? "Add Todo Task" : "Edit Todo Task",
        style: TextStyle(color: Colors.indigo),
      ),
    );
  }

  Widget _buildTitleField(TodoItem todo) {
    return TextFormField(
      validator: (value) {
        if (value.length > 1) return null;
        return "Please enter title for task";
      },
      onSaved: (newValue) {
        title = newValue;
      },
      initialValue: title,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: "Title",
          labelStyle: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
              fontSize: 21)),
    );
  }

  Widget _buildDescField(TodoItem todo) {
    return TextFormField(
      validator: (value) {
        if (value.length > 1) return null;
        return "Please enter description for task";
      },
      onSaved: (value) {
        desc = value;
      },
      cursorColor: Colors.black,
      decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: "Description",
          labelStyle: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
              fontSize: 21)),
      initialValue: desc,
      maxLines: 5,
    );
  }

  Widget urgency(int idx) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedUrgency = idx;
        });
      },
      child: Container(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: urgencyColor[idx]),
        child: idx == selectedUrgency
            ? Icon(
                Icons.check,
                size: 30.0,
                color: Colors.white,
              )
            : Container(
                height: 30,
                width: 30,
              ),
      ),
    );
  }

  Widget _buildUrgencyField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Urgency",
          style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
              fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          // width: 100,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              urgency(0),
              SizedBox(
                width: 10,
              ),
              urgency(1),
              SizedBox(
                width: 10,
              ),
              urgency(2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return RaisedButton(
      child: Text("Save"),
      onPressed: () {
        var todoListInstance = Provider.of<TodoList>(context, listen: false);
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          if (widget.currentTodoItem == null) {
            todoListInstance.addNewTodo(
              TodoItem(
                  title: title, description: desc, urgency: selectedUrgency),
            );
          } else {
            todoListInstance.editTodo(
                TodoItem(
                    title: title,
                    description: desc,
                    urgency: selectedUrgency,
                    isDone: widget.currentTodoItem.isDone),
                widget.index);
          }

          Navigator.pop(context);
        }
      },
    );
  }

  Widget _buildForm(TodoItem todo) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTitleField(todo),
          SizedBox(
            height: 15,
          ),
          _buildUrgencyField(),
          // SizedBox(
          //   height: 100,
          // ),
          _buildDescField(todo),
          // SizedBox(
          //   width: 20,
          // ),
          _buildSaveButton()
        ],
      ),
    );
  }

  Widget _buildBody(TodoItem todo) {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: _buildForm(todo),
    );
  }

  void initState() {
    selectedUrgency =
        widget.currentTodoItem == null ? 0 : widget.currentTodoItem.urgency;
    title = widget.currentTodoItem == null ? " " : widget.currentTodoItem.title;
    desc = widget.currentTodoItem == null
        ? " "
        : widget.currentTodoItem.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(widget.currentTodoItem == null),
      body: _buildBody(widget.currentTodoItem),
    );
  }
}
