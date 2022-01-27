import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo/todo.dart';

class TodoRow extends StatefulWidget {
  const TodoRow(this.todo, this.deleteHandler, this.editHandler, {Key? key})
      : super(key: key);

  final Todo todo;
  final void Function(int) deleteHandler;
  final void Function(int, String) editHandler;

  @override
  _TodoRowState createState() => _TodoRowState();
}

class _TodoRowState extends State<TodoRow> {
  bool _isDone = false;
  bool isError = false;
  TextEditingController todoDescController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isDone = widget.todo.done;
  }

  @override
  void didUpdateWidget(TodoRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isDone = widget.todo.done;
  }

  void _toggleDone(done) {
    setState(() {
      _isDone = done;
    });
  }

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
          value: _isDone,
          onChanged: _toggleDone,
        ),
      ),
    );
  }

  void openEditTodoDialog() {
    todoDescController.text = widget.todo.desc;
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
            ));
  }

  void onEditPressed() {
    if (todoDescController.text.isNotEmpty) {
      setState(() {
        widget.editHandler(widget.todo.id, todoDescController.text);
        todoDescController.clear();
        Navigator.pop(context);
      });
    } else {
      setState(() {
        isError = true;
      });
    }
  }
}
