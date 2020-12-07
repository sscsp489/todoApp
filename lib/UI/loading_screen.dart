import 'package:Todo/UI/todo_list_screen.dart';
import 'package:Todo/data_storing_retrieveing_fun.dart';
import 'package:Todo/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Widget loadingWidget() {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              "Todo App",
              style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  var isloaded;

  void initState() {
    super.initState();
    //for fetch all todos from offline storage
    isloaded = SharedPrefFun().fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: isloaded,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Provider.of<TodoList>(context).initializeData(snapshot.data);
              return TodoListScreen();
            }

            return loadingWidget();
          }),
    );
  }
}
