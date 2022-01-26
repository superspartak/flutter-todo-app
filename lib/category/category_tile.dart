import 'package:flutter/material.dart';
import 'package:flutter_todo_app/category/category.dart';
import 'package:flutter_todo_app/screens/todo_screen.dart';

class CategoryTile extends StatefulWidget {
  const CategoryTile(this.category, this.deleteHandler, {Key? key})
      : super(key: key);

  final Category category;
  final void Function(int) deleteHandler;

  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TodoScreen(category: widget.category)))
              .then((value) => setState(() {}));
        },
        onLongPress: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(widget.category.name),
              content: const Text(
                  'Please choose the action regarding this category.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => {},
                  child: const Text('Edit'),
                ),
                TextButton(
                  onPressed: () => {
                    widget.deleteHandler(widget.category.id),
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
        child: Container(
          height: 144,
          width: 144,
          margin: const EdgeInsetsDirectional.all(16),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsetsDirectional.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Icon(widget.category.icon,
                      size: 48, color: widget.category.color),
                ),
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(widget.category.name,
                          style: const TextStyle(
                            fontSize: 24,
                          )),
                      Text(widget.category.todos.length.toString() + ' Tasks',
                          style: const TextStyle(
                            fontSize: 12,
                          ))
                    ]))
              ],
            ),
          ),
        ));
  }
}
