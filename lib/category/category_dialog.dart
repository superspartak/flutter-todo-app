import 'package:flutter/material.dart';
import 'package:flutter_todo_app/category/category.dart';
import 'package:flutter_todo_app/commons/utils.dart';

class CategoryDialog extends StatefulWidget {
  const CategoryDialog(this.createHandler, {Key? key}) : super(key: key);

  final void Function(Category) createHandler;

  @override
  _CategoryDialogState createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  Color colorValue = Colors.blueGrey;
  IconData iconValue = Icons.hotel_sharp;
  bool isError = false;
  TextEditingController categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter category details.'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            autofocus: true,
            decoration: InputDecoration(
                hintText: 'Ex. Finish homework',
                errorText: isError ? "Can't be empty" : null),
            controller: categoryNameController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton<Color>(
                value: colorValue,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Colors.blueAccent,
                ),
                onChanged: (Color? newValue) {
                  setState(() {
                    colorValue = newValue!;
                  });
                },
                items: colors.map<DropdownMenuItem<Color>>((Color value) {
                  return DropdownMenuItem<Color>(
                    value: value,
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      height: 16,
                      width: 16,
                      decoration:
                          BoxDecoration(color: value, shape: BoxShape.circle),
                    ),
                  );
                }).toList(),
              ),
              DropdownButton<IconData>(
                value: iconValue,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Colors.blueAccent,
                ),
                onChanged: (IconData? newValue) {
                  setState(() {
                    iconValue = newValue!;
                  });
                },
                items: icons.map<DropdownMenuItem<IconData>>((IconData value) {
                  return DropdownMenuItem<IconData>(
                      value: value,
                      child: Icon(
                        value,
                        size: 24,
                        color: Colors.black,
                      ));
                }).toList(),
              ),
            ],
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (categoryNameController.text.isNotEmpty) {
                widget.createHandler(Category(
                    DateTime.now().millisecondsSinceEpoch,
                    categoryNameController.text,
                    iconValue,
                    colorValue, []));
                Navigator.pop(context);
              } else {
                setState(() {
                  isError = true;
                });
              }
            },
            child: const Text('Create'))
      ],
    );
  }
}
