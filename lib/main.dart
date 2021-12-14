import 'package:flutter/material.dart';
import 'package:todo/views/todolist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        appBarTheme:  const AppBarTheme(
          backgroundColor: Colors.lightBlue
        ),
        scaffoldBackgroundColor: Colors.lightBlue
      ),
      home: const TodoList(),
    );
  }
}


