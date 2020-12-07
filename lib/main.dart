import 'package:Todo/UI/loading_screen.dart';
import 'package:Todo/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TodoList(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Mada'),
          home: Scaffold(
            body: Container(
              child: LoadingScreen(),
            ),
          ),
        ));
  }
}
