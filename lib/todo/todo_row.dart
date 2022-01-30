import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo/todo.dart';
import 'package:flutter_todo_app/todo/todo_edit_dialog.dart';

class TodoRow extends StatefulWidget {
  const TodoRow(
      this.todo, this.deleteHandler, this.editHandler, this.toggleHandler,
      {Key? key})
      : super(key: key);

  final Todo todo;
  final void Function(int) deleteHandler;
  final void Function(int, String) editHandler;
  final void Function(int) toggleHandler;

  @override
  _TodoRowState createState() => _TodoRowState();
}

class _TodoRowState extends State<TodoRow> {
  bool isError = false;
  TextEditingController todoDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(widget.todo.desc),
            content:
                const Text('Please choose the action regarding this todo.'),
            actions: <Widget>[
              TextButton(
                onPressed: openEditTodoDialog,
                child: const Text('Edit'),
              ),
              TextButton(
                onPressed: () => {
                  widget.deleteHandler(widget.todo.id),
                  Navigator.pop(context)
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
      child: ListTile(
        title: Text(
          widget.todo.desc,
        ),
        trailing: Checkbox(
          value: widget.todo.done,
          onChanged: (_) => widget.toggleHandler(widget.todo.id),
        ),
      ),
    );
  }

  void openEditTodoDialog() {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (context) => TodoEditDialog(widget.todo, widget.editHandler));
  }
}
