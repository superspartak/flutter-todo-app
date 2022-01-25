import 'package:flutter/material.dart';
import 'package:flutter_todo_app/category/category.dart';
import 'package:flutter_todo_app/screens/main_screen.dart';
import 'package:flutter_todo_app/todo/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Category> categories = [
      Category(1, 'Home', Icons.home, Colors.amber, [
        Todo(11, 'Do shopping', false),
        Todo(12, 'Do shopping', true),
        Todo(13, 'Do shopping', false),
        Todo(14, 'Do shopping', false)
      ]),
      Category(2, 'Work', Icons.work, Colors.green, []),
      Category(3, 'School', Icons.school, Colors.orange, [])
    ];
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(
        categories: categories,
      ),
    );
  }
}
