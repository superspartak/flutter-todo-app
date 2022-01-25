import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo/todo.dart';

class Category {
  int id;
  String name;
  IconData icon;
  Color color;
  List<Todo> todos;

  Category(this.id, this.name, this.icon, this.color, this.todos);
}
