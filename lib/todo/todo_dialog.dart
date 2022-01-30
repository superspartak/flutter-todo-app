import 'package:flutter/material.dart';

class TodoDialog extends StatefulWidget {
  const TodoDialog(this.createHandler, {Key? key}) : super(key: key);

  final void Function(String) createHandler;

  @override
  _TodoDialogState createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  final todoDescController = TextEditingController();
  bool isError = false;

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
      actions: [TextButton(onPressed: onPressed, child: const Text('Create'))],
    );
  }

  void onPressed() {
    setState(() {
      if (todoDescController.text.isNotEmpty) {
        widget.createHandler(todoDescController.text);
        todoDescController.clear();
      } else {
        isError = true;
      }
    });
  }
}
