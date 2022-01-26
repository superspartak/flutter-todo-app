import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo/todo.dart';
import 'package:flutter_todo_app/todo/todo_row.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({
    Key? key,
    required this.category,
    required this.todos,
  }) : super(key: key);

  final String category;
  final List<Todo> todos;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Todo> todos = [];
  final todoDescController = TextEditingController();

  @override
  void initState() {
    super.initState();
    todos = widget.todos;
  }

  Widget _buildTodos() {
    return ListView.builder(
        itemCount: todos.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();
          final index = i ~/ 2;
          return TodoRow(todos[index], _deleteTodo);
        });
  }

  void _deleteTodo(int id) {
    setState(() {
      todos = todos.where((element) => element.id != id).toList();
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
                widget.category,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Expanded(child: _buildTodos())
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: openTodoDialog,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void createTodo() {
    setState(() {
      todos.add(Todo(12, todoDescController.text, false));
      todoDescController.clear();
      Navigator.pop(context);
    });
  }

  void openTodoDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Enter todo description.'),
              content: TextField(
                autofocus: true,
                decoration:
                    const InputDecoration(hintText: 'Ex. Finish homework'),
                controller: todoDescController,
              ),
              actions: [
                TextButton(onPressed: createTodo, child: const Text('Create'))
              ],
            ));
  }
}