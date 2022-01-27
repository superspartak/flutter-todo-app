import 'package:flutter/material.dart';
import 'package:flutter_todo_app/category/category.dart';
import 'package:flutter_todo_app/commons/utils.dart';

class CategoryEditDialog extends StatefulWidget {
  const CategoryEditDialog(this.category, this.editHandler, {Key? key})
      : super(key: key);

  final Category category;
  final void Function(int, String, Color, IconData) editHandler;

  @override
  _CategoryEditDialogState createState() => _CategoryEditDialogState();
}

class _CategoryEditDialogState extends State<CategoryEditDialog> {
  Color colorValue = Colors.blueGrey;
  IconData iconValue = Icons.hotel_sharp;
  bool isError = false;
  TextEditingController categoryNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    categoryNameController.text = widget.category.name;
    iconValue = widget.category.icon;
    colorValue = widget.category.color;
  }

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
                widget.editHandler(
                  widget.category.id,
                  categoryNameController.text,
                  colorValue,
                  iconValue,
                );
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
