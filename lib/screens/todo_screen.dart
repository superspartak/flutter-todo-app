import 'package:flutter/material.dart';
import 'package:flutter_todo_app/category/category.dart';
import 'package:flutter_todo_app/category/category_service.dart';
import 'package:flutter_todo_app/commons/emptyList.dart';
import 'package:flutter_todo_app/todo/todo.dart';
import 'package:flutter_todo_app/todo/todo_dialog.dart';
import 'package:flutter_todo_app/todo/todo_row.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    todos = widget.category.todos;
  }

  Widget _buildTodos() {
    return ListView.builder(
        itemCount: todos.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();
          final index = i ~/ 2;
          return TodoRow(todos[index], _deleteTodo, _editTodo, _toggleTodo);
        });
  }

  void _createTodo(String desc) {
    setState(() {
      todos.add(Todo(DateTime.now().millisecondsSinceEpoch, desc, false));
      CategoryService().saveToStorage(widget.category);
      Navigator.pop(context);
    });
  }

  void _deleteTodo(int id) {
    setState(() {
      todos.removeWhere((element) => element.id == id);
      CategoryService().saveToStorage(widget.category);
    });
  }

  void _editTodo(int id, String desc) {
    setState(() {
      todos.firstWhere((element) => element.id == id).desc = desc;
      CategoryService().saveToStorage(widget.category);
    });
  }

  void _toggleTodo(int id) {
    setState(() {
      var todo = todos.firstWhere((element) => element.id == id);
      todo.done = !todo.done;
      CategoryService().saveToStorage(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 32,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
              Text(
                widget.category.name,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: todos.isNotEmpty
                      ? _buildTodos()
                      : const EmptyList('No todos in this category yet.'))
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: openTodoDialog,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void openTodoDialog() {
    showDialog(context: context, builder: (context) => TodoDialog(_createTodo));
  }
}
