import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo/todo.dart';

class TodoRow extends StatefulWidget {
  const TodoRow(this.todo, this.deleteHandler, {Key? key}) : super(key: key);

  final Todo todo;
  final void Function(int) deleteHandler;

  @override
  _TodoRowState createState() => _TodoRowState();
}

class _TodoRowState extends State<TodoRow> {
  bool _isDone = false;

  @override
  void initState() {
    super.initState();
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
                onPressed: () => {},
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
}
