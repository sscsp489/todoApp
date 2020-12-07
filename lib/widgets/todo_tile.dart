import 'package:Todo/UI/todo_desc_screen.dart';
import 'package:Todo/model/todo_model.dart';
import 'package:Todo/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TodoTile extends StatefulWidget {
  TodoItem todoData;
  int index;
  TodoTile({this.todoData, this.index});

  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  List<Color> urgencyColor = [Colors.green, Colors.yellow, Colors.red];

  Widget radioButton() {
    return InkWell(
      onTap: () {
        setState(() {
          // widget.todoData.isDone = !widget.todoData.isDone;
          Provider.of<TodoList>(context, listen: false)
              .toggleTodoDone(widget.index);
        });
      },
      child: Container(
        alignment: Alignment.center,
        // margin: EdgeInsets.only(left: 15.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.todoData.isDone
                ? Colors.indigoAccent
                : Colors.transparent,
            border: widget.todoData.isDone
                ? Border.all(color: Colors.transparent, width: 2.0)
                : Border.all(
                    color: Colors.blueGrey,
                    width: 2.0,
                  )),
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: widget.todoData.isDone
                ? Icon(
                    Icons.check,
                    size: 15.0,
                    color: Colors.white,
                  )
                : Container(
                    width: 15.0,
                    height: 15.0,
                  )),
      ),
    );
  }

  Widget deleteButton() {
    return IconButton(
        icon: Icon(
          Icons.delete_outline,
          color: Colors.indigo[400],
        ),
        onPressed: () {
          Provider.of<TodoList>(context, listen: false)
              .deleteTodo(widget.index);
        });
  }

  Widget _buildTile() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TodoTaskDesc(index: widget.index)));
      },
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          padding: EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    radioButton(),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width / 100) * 55,
                      child: Text(
                        widget.todoData.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18,
                            decoration: widget.todoData.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: urgencyColor[widget.todoData.urgency]),
                        child: Container(
                          height: 10,
                          width: 10,
                        ),
                      ),
                      deleteButton(),
                    ],
                  ))
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTile();
  }
}
