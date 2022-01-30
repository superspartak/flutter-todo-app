import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo/todo.dart';

class Category {
  int id;
  String name;
  IconData icon;
  Color color;
  List<Todo> todos;

  Category(this.id, this.name, this.icon, this.color, this.todos);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon.codePoint,
      'color': color.value,
      'todos': todos.map((x) => x.toMap()).toList(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      map['id']?.toInt() ?? 0,
      map['name'] ?? '',
      IconData(map['icon'], fontFamily: 'MaterialIcons'),
      Color(map['color']),
      List<Todo>.from(map['todos']?.map((x) => Todo.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}
