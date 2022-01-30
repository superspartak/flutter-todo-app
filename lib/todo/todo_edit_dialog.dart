import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo/todo.dart';

class TodoEditDialog extends StatefulWidget {
  const TodoEditDialog(this.todo, this.editHandler, {Key? key})
      : super(key: key);

  final Todo todo;
  final Function(int, String) editHandler;
  @override
  _TodoEditDialogState createState() => _TodoEditDialogState();
}

class _TodoEditDialogState extends State<TodoEditDialog> {
  bool isError = false;
  TextEditingController todoDescController = TextEditingController();

  @override
  void didUpdateWidget(covariant TodoEditDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    todoDescController.text = widget.todo.desc;
  }

  void onEditPressed() {
    setState(() {
      if (todoDescController.text.isNotEmpty) {
        widget.editHandler(widget.todo.id, todoDescController.text);
        todoDescController.clear();
      } else {
        isError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter todo description.'),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(
            hintText: 'Ex. Finish homework',
            errorText: isError ? "Can't be empty" : null),
        controller: todoDescController,
      ),
      actions: [
        TextButton(onPressed: onEditPressed, child: const Text('Edit'))
      ],
    );
  }
}
