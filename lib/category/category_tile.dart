import 'package:flutter/material.dart';
import 'package:flutter_todo_app/category/category.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(this.category, this.deleteHandler, {Key? key})
      : super(key: key);

  final Category category;
  final void Function(int) deleteHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Icon(category.icon, size: 48, color: category.color),
            ),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(category.name,
                      style: const TextStyle(
                        fontSize: 24,
                      )),
                  Text(category.todos.length.toString() + ' Tasks',
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ]))
          ],
        ),
      ),
    );
  }
}
